import 'package:g_project/models/register_user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccesState extends RegisterStates {
  final RegisterUserModel registeruserModel;

  RegisterSuccesState(this.registeruserModel);
}

class RegisterErrorState extends RegisterStates {
  RegisterErrorState(e);
}

class RegisterPassVisState extends RegisterStates {}
