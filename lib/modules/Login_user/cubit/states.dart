
// ignore_for_file: prefer_typing_uninitialized_variables

abstract class LoginUserStates {}

class LoginUserInitState extends LoginUserStates {}

class LoginUserLoadingState extends LoginUserStates {}

class LoginUserSuccesState extends LoginUserStates {}
class LoginUserErrorState extends LoginUserStates {
  final error;

  LoginUserErrorState(this.error);
}

class LoginUserPassVisState extends LoginUserStates {}