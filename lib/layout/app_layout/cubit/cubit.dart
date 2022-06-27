import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/user/category_model.dart';
import 'package:g_project/models/user/change_favourites_model.dart';
import 'package:g_project/models/user/checkout_model.dart';
import 'package:g_project/models/user/edit_profile_model.dart';
import 'package:g_project/models/user/products_model.dart';
import 'package:g_project/models/user/profile_model.dart';
import 'package:g_project/modules/user/Cart/cart.dart';
import 'package:g_project/modules/user/Home/home.dart';
import 'package:g_project/modules/user/categories/categories.dart';
import 'package:g_project/modules/user/more_screen/more.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import '../../../models/user/favourite_model.dart';

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
            token: '$token')
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
            token: '$token')
        .then((value) {
      favModel = FavouritesModel.fromJson(value.data);
      emit(AppSuccesGetFavouritesState());
    }).catchError((e) {
      emit(AppErrorGetFavouritesState());
    });
  }

  void deleteFav() {
    DioHelper.deleteData(
            url: 'https://care.ssd-co.com/api/client/wishlist', token: token)
        .then((value) {
      getFavourites();
      emit(AppSuccesDeleteFavState());
    }).catchError((e) {
      emit(AppErrorDeleteFavState());
    });
  }

  ProfileModel? proModel;

  void getProfile() async {
    await DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/profile/info',
            token: '$token')
        .then((value) {
      proModel = ProfileModel.fromJson(value.data);
      emit(AppSuccesGetProfileState());
    }).catchError((e) {
      emit(AppErrorGetProfileState());
    });
  }

  CheckOutModel? checkOut;

  void postCheckOut() {
    if (productID.length == 1) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 2) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 3) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 4) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 5) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 6) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
            'product_ids[5]': productID[5],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 7) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
            'product_ids[5]': productID[5],
            'product_ids[6]': productID[6],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 8) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
            'product_ids[5]': productID[5],
            'product_ids[6]': productID[6],
            'product_ids[7]': productID[7],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 9) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
            'product_ids[5]': productID[5],
            'product_ids[6]': productID[6],
            'product_ids[7]': productID[7],
            'product_ids[8]': productID[8],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    } else if (productID.length == 10) {
      DioHelper.postData(
          url: 'https://care.ssd-co.com/api/cart/add?',
          token: token,
          query: {
            'client_id': proModel!.data![0].id,
            'client_name': proModel!.data![0].name,
            'client_phone': proModel!.data![0].mobile,
            'new_address': proModel!.data![0].address,
            'payment_method': 'cash',
            'status': '0',
            'check': '1',
            'Payment_Date': '132135',
            'product_ids[0]': productID[0],
            'product_ids[1]': productID[1],
            'product_ids[2]': productID[2],
            'product_ids[3]': productID[3],
            'product_ids[4]': productID[4],
            'product_ids[5]': productID[5],
            'product_ids[6]': productID[6],
            'product_ids[7]': productID[7],
            'product_ids[8]': productID[8],
            'product_ids[9]': productID[9],
          }).then((value) {
        emit(AppSuccesCheckOutState());
      }).catchError((e) {
        emit(AppErrorCheckOutState());
      });
    }
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
            token: ' $token')
        .then((value) {
      editProfile = EditProfile.fromJson(value.data);
      getProfile();
      emit(AppSuccesEditProfileState());
    }).catchError((e) {
      emit(AppErrorEditProfileState());
    });
  }

  double allPrice() {
    double all = 0.0;
    for (var i = 0; i < productPrices.length; i++) {
      all += double.tryParse(productPrices[i])!;
    }
    return all;
  }

  Widget cartItem(
    context,
    List<String> productNames,
    List<String> productPrices,
    List<String> productImages,
    int index,
    /* Dataa data */
  ) {
    if (productNames == <String>[]) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {},
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
                        image: NetworkImage(productImages[index]),
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
                            productNames[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total: ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    '${productPrices[index]} LE',
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
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      const Color.fromARGB(209, 238, 238, 238),
                                  child: GestureDetector(
                                    onTap: () {
                                      productNames.removeAt(index);
                                      productImages.removeAt(index);
                                      productPrices.removeAt(index);
                                      productID.removeAt(index);
                                      emit(AppSuccesCartsState());
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/Trash.svg',
                                      width: 24,
                                    ),
                                  )),
                              const SizedBox(
                                width: 15,
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
