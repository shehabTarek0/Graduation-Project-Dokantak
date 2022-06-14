// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:g_project/models/user/login_user_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccesState extends LoginStates {
  final LoginUserModel userModel;
  LoginSuccesState(this.userModel);
}

class LoginErrorState extends LoginStates {
  final error;

  LoginErrorState(this.error);
}

class LoginPassVisState extends LoginStates {}
