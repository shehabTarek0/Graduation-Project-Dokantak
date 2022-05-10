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

  void getCategoryProducts() {
    DioHelper.getData(
            url: 'https://care.ssd-co.com/api/client/category/product/12')
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
            token:
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5M2U4NTVlMi0zMDYxLTQ2NGItYTljNC0zMzYwMDJhNDcxMGUiLCJqdGkiOiJlNTM0MmQ3Y2U3YmE1YjBjN2E1NWQ4OGRhZTk0ZDU1ZTk5ZDNjZDI0MTYzZjJlZDE2ZGRiZDllZTIwODRhZjNmYjA3NTdlYzdjZmQ5NDcxZiIsImlhdCI6MTY0ODQ3MDExNC41MTY3MDksIm5iZiI6MTY0ODQ3MDExNC41MTY3MTQsImV4cCI6MTY4MDAwNjExNC41MTQ2MTUsInN1YiI6IjIwIiwic2NvcGVzIjpbXX0.XT1XuDdAYaLvh49eHhjyEYTTSZGht07E9yu2N71eLH-TuJByZpmMw3wdMplbBgiA-5UbDqhjCBs18_WnN-nFwFpNzbKyNDBsxPGYb7TC4WBrNwhKCCgV-NooJlpGANc6Du-vED_J8jxOUn_vw8shqNxYQ7Ps0iwiMvDwuGAtm03WtShGkyibGXSujs1dxydEd0qo_UKmjD2fR77V6zu4nLCE7pdgYn1qNDjIpdkDfwK56ThfzHM9OGxe89bjb44ksiOXu21bWFCf_ssuMAiHPwsg5V1_0V-HZkOTuTEqm2HWLSpwiEhOokLv_D36WOaFx-UgVnBEYB_ASeB_oojcmWjsLw73RFev_JjUptF1nBpNrlHrbVCSIL6_NSybcF0QNqyo2fqZJDnRTC-Zt2FoUAj69qM_oKA27Rs4EyJ6LmSHuOmO6gdaI4H4v_LHUX4w7lZsfyswNL_m9UTOHLYvE4Qj043bDXF7Hhl5G4cFmv8EM7PNEhfES8URKvXTe7zw3_z4ZOZC8HW7gFPuyyVj9ii5CrVUCq3pgRtEvM_oMVwCm7oPDC9PZoshJThm9M6wZQEfhCvDICEWfcnAuWnDRcWNofhi-8fRx9gURMXVCjJ7nNhZhEwkbnk6YOkcHnVOugpencG3sQQWIOwNAOng01j38jEGEWOpFL3Ssoj5ovQ')
        .then((value) {
      changeFavourite = ChangeFavourites.fromJson(value.data);
      getFavourites();
      emit(AppSuccesChangeFavouritesState());
    }).catchError((e) {
      emit(AppErrorChangeFavouritesState());
    });
  }

  FavouritesModel? favModel;
  void getFavourites() async {
    emit(AppLoadingGetFavouritesState());
    await DioHelper.getData(
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
