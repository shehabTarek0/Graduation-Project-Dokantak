import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/Favourite_model.dart';
import 'package:g_project/models/Products_model.dart';
import 'package:g_project/models/category_model.dart';
import 'package:g_project/models/change_favourites_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/modules/Home/home.dart';
import 'package:g_project/modules/categories/categories.dart';
import 'package:g_project/modules/more_screen/more.dart';
import 'package:g_project/modules/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

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

  Widget buildCartItem(context, Dataa data) {
    if (getPro == null) {
      return const SizedBox();
    } else {
      List<Dataa> dec = Dataa.decode(getPro!);
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
}
