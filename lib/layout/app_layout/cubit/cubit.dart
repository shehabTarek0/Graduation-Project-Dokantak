import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/user/category_model.dart';
import 'package:g_project/models/user/change_favourites_model.dart';
import 'package:g_project/models/user/checkout_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/models/user/edit_profile_model.dart';
import 'package:g_project/models/user/products_model.dart';
import 'package:g_project/models/user/profile_model.dart';
import 'package:g_project/modules/user/Cart/cart.dart';
import 'package:g_project/modules/user/Home/home.dart';
import 'package:g_project/modules/user/categories/categories.dart';
import 'package:g_project/modules/user/more_screen/more.dart';
import 'package:g_project/modules/user/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/user/favourite_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const HomeScreen(),
    const CategoryScreen(),
    CartScreen(),
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

  CategoryProductsModel? productsModel;

  void getSearchProducts() {
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/category/product/12')
        .then((value) {
      productsModel = CategoryProductsModel.fromJson(value.data);
      emit(AppSuccesSearchProductsState());
    }).catchError((e) {
      emit(AppErrorSearchProductsState());
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

  CheckOutModel? checkOut;

  void postCheckOut() {
    DioHelper.postData(
        url: 'https://care.ssd-co.com/api/cart/add?',
        token: 'Bearer $token',
        query: {
          'client_id': proModel!.data![0].id,
          'client_name': proModel!.data![0].name,
          'client_phone': proModel!.data![0].mobile,
          'new_address': proModel!.data![0].address,
          'payment_method': 'cash',
          'status': '0',
          'check': '1',
          'Payment_Date': '132135',
          'product_ids[0]': idPro,
          'product_ids[1]': idProduct0,
        }).then((value) {
      emit(AppSuccesCheckOutState());
    }).catchError((e) {
      emit(AppErrorCheckOutState());
    });
  }

  EditProfile? editProfile;

  void profileEdit({
    required String name,
    required String email,
    required String address,
  }) {
    emit(AppLoadingEditProfileState());
    DioHelper.postData(
            url: 'https://care.ssd-co.com/api/client/update',
            data: {
              "name": name,
              "email": email,
              "address": address,
            },
            token: 'Bearer $token')
        .then((value) {
      editProfile = EditProfile.fromJson(value.data);
      getProfile();
      emit(AppSuccesEditProfileState());
    }).catchError((e) {
      emit(AppErrorEditProfileState());
    });
  }

  Widget buildCartItem(context, Dataa data) {
    if (getPro == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec = Dataa.decode(getPro!);
      pricePro = double.tryParse(dec[0].price!);
      idPro = dec[0].id!;
      b = 1;
      return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'productCard', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(dec[0].photo!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dec[0].productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${dec[0].price} LE',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'products');
                                  getPro = null;
                                  pricePro = 0.0;
                                  idPro = null;
                                  b = 0;
                                  emit(AppLoadingCartsState());
                                  AppCubit.get(context)
                                      .buildCartItem(context, data);
                                },
                                icon: const Icon(FontAwesome5.trash),
                                color: HexColor('ED1B36'),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildCartItem0(context, Dataa data) {
    if (getProduct0 == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec0 = Dataa.decode(getProduct0!);
      priceProduct0 = double.tryParse(dec0[0].price!);
      idProduct0 = dec0[0].id!;
      b0 = 1;
      return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'productCard', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(dec0[0].photo!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dec0[0].productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${dec0[0].price} LE',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'product0');
                                  getProduct0 = null;
                                  priceProduct0 = 0.0;
                                  idProduct0 = null;
                                  b0 = 0;
                                  emit(AppLoadingCartsState());
                                  AppCubit.get(context)
                                      .buildCartItem0(context, data);
                                },
                                icon: const Icon(FontAwesome5.trash),
                                color: HexColor('ED1B36'),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildCartItem1(context, Dataa data) {
    if (getProduct1 == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec1 = Dataa.decode(getProduct1!);
      idProduct1 = dec1[0].id!;
      priceProduct1 = double.tryParse(dec1[0].price!);
      b1 = 1;
      return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'productCard', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(dec1[0].photo!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dec1[0].productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${dec1[0].price} LE',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'product1');
                                  getProduct1 = null;
                                  priceProduct1 = 0.0;
                                  idProduct1 = null;
                                  b1 = 0;
                                  emit(AppLoadingCartsState());
                                  AppCubit.get(context)
                                      .buildCartItem1(context, data);
                                },
                                icon: const Icon(FontAwesome5.trash),
                                color: HexColor('ED1B36'),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildCartItem2(context, Dataa data) {
    if (getProduct2 == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec2 = Dataa.decode(getProduct2!);
      idProduct2 = dec2[0].id!;
      priceProduct2 = double.tryParse(dec2[0].price!);
      b2 = 1;
      return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'productCard', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(dec2[0].photo!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dec2[0].productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${dec2[0].price} LE',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'product2');
                                  getProduct2 = null;
                                  priceProduct2 = 0.0;
                                  idProduct2 = null;
                                  b2 = 0;
                                  emit(AppLoadingCartsState());
                                  AppCubit.get(context)
                                      .buildCartItem2(context, data);
                                },
                                icon: const Icon(FontAwesome5.trash),
                                color: HexColor('ED1B36'),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildCartItem3(context, Dataa data) {
    if (getProduct3 == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec3 = Dataa.decode(getProduct3!);
      priceProduct3 = double.tryParse(dec3[0].price!);
      idProduct3 = dec3[0].id!;
      b3 = 1;
      return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'productCard', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(dec3[0].photo!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dec3[0].productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${dec3[0].price} LE',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'product3');
                                  getProduct3 = null;
                                  priceProduct3 = 0.0;
                                  idProduct3 = null;
                                  b3 = 0;
                                  emit(AppLoadingCartsState());
                                  AppCubit.get(context)
                                      .buildCartItem3(context, data);
                                },
                                icon: const Icon(FontAwesome5.trash),
                                color: HexColor('ED1B36'),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  int total() {
    // emit(AppTotalLoad());
    b ??= 0;
    b0 ??= 0;
    b1 ??= 0;
    b2 ??= 0;
    b3 ??= 0;
    int totalnum = b! + b0! + b1! + b2! + b3!;
    // emit(AppTotalSucc());
    return totalnum;
  }

  double totalPrice() {
    // emit(AppTotalLoad());
    pricePro ??= 0;
    priceProduct0 ??= 0;
    priceProduct1 ??= 0;
    priceProduct2 ??= 0;
    priceProduct3 ??= 0;
    double totalnum = pricePro! +
        priceProduct0! +
        priceProduct1! +
        priceProduct2! +
        priceProduct3!;
    // emit(AppTotalSucc());
    return totalnum;
  }
}
