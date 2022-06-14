import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/modules/marchant/register_mer/cubit/states.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';

class RegisterUserCubit extends Cubit<RegisterUserStates> {
  RegisterUserCubit() : super(RegisterUserInitialState());

  static RegisterUserCubit get(context) => BlocProvider.of(context);
  // ShopLoginModel registerModel;

  void merRegister(
      {required String name,
      required String email,
      required String password,
      required String passwordCon}) {
    emit(RegisterUserLoadingState());
    DioHelper.postData(
        url: 'https://care.ssd-co.com/api/admin/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordCon,
        }).then((value) {
      // registerMerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterUserSuccesState());
    }).catchError((e) {
      emit(RegisterUserErrorState(e));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeIconPass() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterUserPassVisState());
  }
}
