import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/modules/marchant/register_user/cubit/states.dart';

class RegisterUserCubit extends Cubit<RegisterUserStates> {
  RegisterUserCubit() : super(RegisterUserInitialState());

  static RegisterUserCubit get(context) => BlocProvider.of(context);
  // ShopLoginModel registerModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterUserLoadingState());
    /*DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterSuccesState(registerModel));
    }).catchError((e) {
      print(e);
      emit(RegisterErrorState(e));
    }); */
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
