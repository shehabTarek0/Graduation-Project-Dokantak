import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/modules/Login_user/cubit/states.dart';

class LoginUserCubit extends Cubit<LoginUserStates> {
  LoginUserCubit() : super(LoginUserInitState());
  static LoginUserCubit get(context) => BlocProvider.of(context);

  // LoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginUserLoadingState());
    
  }



  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeIconPass() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginUserPassVisState());
  }
}