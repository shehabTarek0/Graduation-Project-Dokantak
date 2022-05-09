import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/app_layout.dart';
import 'package:g_project/modules/Login_user/cubit/cubit.dart';
import 'package:g_project/modules/Login_user/cubit/states.dart';
import 'package:g_project/modules/register/register_screen.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginUserScreen extends StatelessWidget {
  LoginUserScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginUserCubit(),
      child: BlocConsumer<LoginUserCubit, LoginUserStates>(
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
                              'login now to earn money with Dokantek',
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
                                    LoginUserCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                isPassword: LoginUserCubit.get(context).isPassword,
                                controller: passController,
                                suffix: LoginUserCubit.get(context).suffix,
                                suffixPressed: () {
                                  LoginUserCubit.get(context).changeIconPass();
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
                            state is! LoginUserLoadingState
                                ? defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginUserCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passController.text);
                                        navigateAndFinish(context, const AppLayout());
                                      }
                                    },
                                    text: 'login',
                                    background: HexColor('ED1B36'))
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
                                      navigateTo(context, RegisterScreen());
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
            /* if (state is LoginSuccesState) {
              if (state.loginModel.status!) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                showToast(
                    text: state.loginModel.message!, state: ToastStates.e);
                print(state.loginModel.message);
              }
            } */
          }),
    );
  }
}
