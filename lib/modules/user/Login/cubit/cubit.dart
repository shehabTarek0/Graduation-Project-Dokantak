import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/models/login_user_model.dart';
import 'package:g_project/modules/user/Login/cubit/states.dart';
import 'package:g_project/shared/network/end_points.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginUserModel? userModel;
  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value) {
      userModel = LoginUserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'id', value: userModel!.data!.id);
      emit(LoginSuccesState(userModel!));
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeIconPass() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPassVisState());
  }
}
