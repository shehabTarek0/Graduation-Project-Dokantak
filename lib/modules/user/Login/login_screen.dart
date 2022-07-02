// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/app_layout.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/modules/user/Login/cubit/cubit.dart';
import 'package:g_project/modules/user/Login/cubit/states.dart';
import 'package:g_project/modules/user/register/register_screen.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          builder: (context, state) => Scaffold(
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
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'login now to browse our hot offers',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
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
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                isPassword: LoginCubit.get(context).isPassword,
                                controller: passController,
                                suffix: LoginCubit.get(context).suffix,
                                suffixPressed: () {
                                  LoginCubit.get(context).changeIconPass();
                                },
                                type: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'The password is too short';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline),
                            const SizedBox(
                              height: 25,
                            ),
                            state is! LoginLoadingState
                                ? defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passController.text);
                                        AppCubit.get(context).getProfile();
                                        AppCubit.get(context).getFavourites();
                                      }
                                    },
                                    text: 'login',
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    background: mainColor)
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(fontSize: 16),
                                ),
                                defaultTextButton(
                                    onPress: () {
                                      navigateTo(
                                          context, const RegisterScreen());
                                    },
                                    text: 'Register Now',
                                    style: const TextStyle(fontSize: 16))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          listener: (context, state) {
            if (state is LoginSuccesState) {
              if (state.userModel.success!) {
                flutterToast(
                    text: state.userModel.message!, state: ToastStates.S);
                CacheHelper.saveData(
                        key: 'token', value: state.userModel.data!.token)
                    .then((value) {
                  token = state.userModel.data!.token;
                  AppCubit.get(context).getProfile();
                  AppCubit.get(context).getFavourites();
                  navigateAndFinish(context, const AppLayout());
                });
              }
            }
            if (state is LoginErrorState) {
              flutterToast(
                  text: 'username or password is wrong', state: ToastStates.E);
            }
          }),
    );
  }
}
