// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/models/register_user_model.dart';
import 'package:g_project/modules/register/cubit/states.dart';
import 'package:g_project/shared/network/end_points.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterUserModel? registeruserModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation' : password,
      'mobile': phone,
      'age' :"25",
      'address' : "ssssssssssss ssssss s  ssssssssssssssss sssssssss ssssss",
      'gender' : "male",
    }).then((value) {
      registeruserModel = RegisterUserModel.fromJson(value.data);
      emit(RegisterSuccesState(registeruserModel!));
    }).catchError((e) {
      emit(RegisterErrorState(e));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeIconPass() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPassVisState());
  }
}
