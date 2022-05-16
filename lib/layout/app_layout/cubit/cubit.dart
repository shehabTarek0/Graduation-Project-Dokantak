import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/Favourite_model.dart';
import 'package:g_project/models/Products_model.dart';
import 'package:g_project/models/category_model.dart';
import 'package:g_project/models/change_favourites_model.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/modules/Home/home.dart';
import 'package:g_project/modules/categories/categories.dart';
import 'package:g_project/modules/more_screen/more.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const MoreScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  CategoryClassModel? categoryModel;

  void getCategory() {
    DioHelper.getData(url: 'https://care.ssd-co.com/api/index/category')
        .then((value) {
      categoryModel = CategoryClassModel.fromJson(value.data);
      emit(AppSuccesGetCategoryState());
    }).catchError((e) {
      emit(AppErrorGetCategoryState());
    });
  }

  CategoryProductsModel? categoryProductsModel;

  void getCategoryProducts(int id) {
    emit(AppLoadingGetCategoryProductsState());
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/category/product/$id')
        .then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      emit(AppSuccesGetCategoryProductsState());
    }).catchError((e) {
      emit(AppErrorGetCategoryProductsState());
    });
  }

  bool isFavourite = false;
  void changeF(int id) {
    isFavourite = !isFavourite;
    emit(App());
  }

  ChangeFavourites? changeFavourite;

  void changeFavourites(int id) {
    DioHelper.postData(
            url: 'https://care.ssd-co.com/api/client/wishlist',
            data: {"product_id": id},
            token: 'Bearer $token')
        .then((value) {
      changeFavourite = ChangeFavourites.fromJson(value.data);
      getFavourites();
      emit(AppSuccesChangeFavouritesState());
    }).catchError((e) {
      emit(AppErrorChangeFavouritesState());
      print(e);
    });
  }

  FavouritesModel? favModel;
  void getFavourites() {
    emit(AppLoadingGetFavouritesState());
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/wishlist/products',
            token: 'Bearer $token')
        .then((value) {
      favModel = FavouritesModel.fromJson(value.data);
      emit(AppSuccesGetFavouritesState());
    }).catchError((e) {
      emit(AppErrorGetFavouritesState());
    });
  }

  ProfileModel? proModel;

  void getProfile() async {
    await DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/profile/info',
            token: 'Bearer $token')
        .then((value) {
      proModel = ProfileModel.fromJson(value.data);
      emit(AppSuccesGetProfileState());
    }).catchError((e) {
      emit(AppErrorGetProfileState());
    });
  }
}
