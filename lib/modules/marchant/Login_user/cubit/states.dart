// ignore_for_file: prefer_typing_uninitialized_variables

abstract class LoginMarStates {}

class LoginMarInitState extends LoginMarStates {}

class LoginMarLoadingState extends LoginMarStates {}

class LoginMarrSuccesState extends LoginMarStates {}

class LoginMarErrorState extends LoginMarStates {
  final error;

  LoginMarErrorState(this.error);
}

class LoginMarPassVisState extends LoginMarStates {}
