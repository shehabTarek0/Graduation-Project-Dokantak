import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/modules/marchant/Login_user/cubit/states.dart';

class LoginMarCubit extends Cubit<LoginMarStates> {
  LoginMarCubit() : super(LoginMarInitState());
  static LoginMarCubit get(context) => BlocProvider.of(context);

  // LoginModel loginModel;
  void marLogin({required String email, required String password}) {
    emit(LoginMarLoadingState());
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeIconPass() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginMarPassVisState());
  }
}
