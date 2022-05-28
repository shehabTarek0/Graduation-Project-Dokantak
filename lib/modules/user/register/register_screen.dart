// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_project/modules/user/Login/login_screen.dart';
import 'package:g_project/modules/user/register/cubit/cubit.dart';
import 'package:g_project/modules/user/register/cubit/states.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                          text: 'User Name',
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          prefix: Icons.person),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                          text: 'Email',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                          text: 'Password',
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: passController,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context).changeIconPass();
                          },
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'The password is too short';
                            } else if (value.toString().length < 8) {
                              return "please Use 8 or more characters ";
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                          text: 'Phone',
                          controller: phoneController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your Phone';
                            } else if (value.toString().length != 11) {
                              return 'the phone number is not available';
                            }
                            return null;
                          },
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 35,
                      ),
                      defaultButton(
                          function: () {
                            RegisterCubit.get(context).pickImage();
                          },
                          text: 'Choose photo',
                          height: 60,
                          width: 170,
                          isUpperCase: false,
                          background: Colors.grey[400],
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 20)),
                      const SizedBox(
                        height: 35,
                      ),
                      state is! RegisterLoadingState
                          ? defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                      phone: phoneController.text);
                                  // navigateAndFinish(context, LoginScreen());
                                }
                              },
                              text: 'REGISTER',
                              background: mainColor)
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is RegisterSuccesState) {
          if (state.registeruserModel.success!) {
            /* CacheHelper.saveData(
                        key: 'token', value: state.registeruserModel.data!.token)
                    .then((value) {
                  token = state.registerModel.data!.token;
                  navigateAndFinish(context, LoginScreen());
                }); */
            Fluttertoast.showToast(
                msg: state.registeruserModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            navigateAndFinish(context, LoginScreen());
          } else {
            Fluttertoast.showToast(
                msg: state.registeruserModel.data!.name![0],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } /* else {
                showToast(
                    text: state.registerModel.message!, state: ToastStates.e);
                print(state.registerModel.message);
              } */
        }
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(
              msg: 'Error! Try Again',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }),
    );
  }
}