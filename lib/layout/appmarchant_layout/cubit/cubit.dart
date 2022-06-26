import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/models/merchant/all_products_model.dart';
import 'package:g_project/models/merchant/delete_product_model.dart';
import 'package:g_project/models/merchant/get_category_model.dart';
import 'package:g_project/models/merchant/orders_model.dart';
import 'package:g_project/modules/marchant/home/mar_home.dart';
import 'package:g_project/modules/marchant/more/more_mar.dart';
import 'package:g_project/modules/marchant/orders/orders.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

class MarCubit extends Cubit<MarStates> {
  MarCubit() : super(MarInitState());
  static MarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const MarHome(),
    const OrdersScreen(),
    const MarMore()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(MarBottomNavState());
  }

  AllProductsModel? allProducts;

  void getAllProducts() async {
    emit(MarLoadingAllProductsState());
    await DioHelper.getData(
            url: 'https://care.ssd-co.com/api/admin/product', token: tokenMer)
        .then((value) {
      allProducts = AllProductsModel.fromJson(value.data);
      emit(MarSuccesAllProductsState());
    }).catchError((e) {
      emit(MarErrorAllProductsState());
    });
  }

  CategoryModel? category;

  void getMerCategory() {
    emit(MarLoadingAllCategoryState());
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/admin/category', token: tokenMer)
        .then((value) {
      category = CategoryModel.fromJson(value.data);
      emit(MarSuccesAllCategoryState());
    }).catchError((e) {
      emit(MarErrorAllCategoryState());
    });
  }

  OrdersModel? orderModel;
  void getOrders() {
    emit(MarLoadingAllOrdersState());
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/admin/orders', token: tokenMer)
        .then((value) {
      orderModel = OrdersModel.fromJson(value.data);
      emit(MarSuccesAllOrdersState());
    }).catchError((e) {
      emit(MarErrorAllOrdersState());
    });
  }

  DeleteProductModel? deleteProductt;

  Future deleteProduct(int id) async {
    await DioHelper.deleteData(
            url: 'https://care.ssd-co.com/api/admin/product/$id',
            token: tokenMer)
        .then((value) {
      deleteProductt = DeleteProductModel.fromJson(value.data);
      emit(MarSuccesDeleteProductState());
    }).catchError((e) {
      emit(MarErrorDeleteProductState());
    });
  }

  void editProduct(
      {required int? id,
      required String productN,
      required String productD,
      required String productP,
      required String catId}) {
    DioHelper.putData(
        url: 'https://care.ssd-co.com/api/admin/product/$id',
        token: tokenMer,
        data: {
          "Product_name": productN,
          "description": productD,
          "price": productP,
          "category_id": catId
        }).then((value) {
      deleteProductt = DeleteProductModel.fromJson(value.data);
      emit(MarSuccesEditProductState());
    }).catchError((e) {
      emit(MarErrorEditProductState());
      print(e);
    });
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProduct = File(pickedFile.path);
      emit(MarSuccesAddPhotoProductsState());
    } else {
      flutterToast(text: 'Try Again to upload photo', state: ToastStates.E);
      emit(MarErrorAddPhotoProductsState());
    }
  }
}
