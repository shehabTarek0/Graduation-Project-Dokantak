// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:g_project/models/login_user_model.dart';

abstract class AppStates {}

class AppInitState extends AppStates {}

class AppBottomNavState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}

class AppSuccesHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppSuccesState extends AppStates {
  final LoginUserModel userModel;
  AppSuccesState(this.userModel);
}

class AppErrorState extends AppStates {
  final error;

  AppErrorState(this.error);
}

class AppLoadingUserState extends AppStates {}

class AppPassVisState extends AppStates {}

class AppSuccesUserState extends AppStates {}

class AppErrorUserState extends AppStates {}

class AppSuccesGetCategoryState extends AppStates {}

class AppErrorGetCategoryState extends AppStates {}

class AppLoadingGetCategoryProductsState extends AppStates {}

class AppSuccesGetCategoryProductsState extends AppStates {}

class AppErrorGetCategoryProductsState extends AppStates {}

class AppSuccesChangeFavouritesState extends AppStates {}

class AppErrorChangeFavouritesState extends AppStates {}

class AppSuccesGetFavouritesState extends AppStates {}

class AppLoadingGetFavouritesState extends AppStates {}

class AppErrorGetFavouritesState extends AppStates {}

class AppSuccesGetProfileState extends AppStates {}

class AppErrorGetProfileState extends AppStates {}

class App extends AppStates {}
