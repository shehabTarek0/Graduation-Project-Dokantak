// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:g_project/models/merchant/login_mer_model.dart';

abstract class LoginMarStates {}

class LoginMarInitState extends LoginMarStates {}

class LoginMarLoadingState extends LoginMarStates {}

class LoginMarrSuccesState extends LoginMarStates {
  final LoginMerModel merModel;
  LoginMarrSuccesState(this.merModel);
}

class LoginMarErrorState extends LoginMarStates {
  final error;
  LoginMarErrorState(this.error);
}

class LoginMarPassVisState extends LoginMarStates {}
