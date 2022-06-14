import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/models/merchant/login_mer_model.dart';
import 'package:g_project/modules/marchant/Login_mer/cubit/states.dart';
import '../../../../shared/network/remote/dio_helper/dio_helper.dart';

class LoginMarCubit extends Cubit<LoginMarStates> {
  LoginMarCubit() : super(LoginMarInitState());
  static LoginMarCubit get(context) => BlocProvider.of(context);

  LoginMerModel? merModel;
  void marLogin({required String email, required String password}) async {
    emit(LoginMarLoadingState());
    await DioHelper.postData(
        url: 'https://care.ssd-co.com/api/admin/login',
        data: {'email': email, 'password': password}).then((value) {
      merModel = LoginMerModel.fromJson(value.data);
      emit(LoginMarrSuccesState(merModel!));
    }).catchError((e) {
      emit(LoginMarErrorState(e.toString()));
    });
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
