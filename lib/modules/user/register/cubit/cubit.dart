// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/models/user/register_user_model.dart';
import 'package:g_project/modules/user/register/cubit/states.dart';
import 'package:g_project/shared/network/end_points.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterUserModel? registeruserModel;
  String? imageName;
  String? base64;
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
            url: REGISTER,
            data: {
              'name': name,
              'email': email,
              'password': password,
              'password_confirmation': password,
              'mobile': phone,
              'age': "25",
              'address': "sssssssss",
              'gender': "male",
              'photo': 'clients/$imageName'
            },
            c: "multipart/form-data; boundary=<calculated when request is sent>")
        .then((value) {
      registeruserModel = RegisterUserModel.fromJson(value.data);
      emit(RegisterSuccesState(registeruserModel!));
    }).catchError((e) {
      emit(RegisterErrorState(e));
      print(e);
      print(imageName);
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

  File? imagee;

  Future pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (image == null) return;
      imagee = File(image.path);
      base64 = base64Encode(imagee!.readAsBytesSync());
      imageName = imagee!.path.substring(imagee!.path.lastIndexOf('r') + 1);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
