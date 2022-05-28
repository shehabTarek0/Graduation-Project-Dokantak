import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/modules/marchant/register_user/cubit/cubit.dart';
import 'package:g_project/modules/marchant/register_user/cubit/states.dart';
import 'package:g_project/modules/user/Login/login_screen.dart';
import 'package:g_project/modules/user/register/cubit/states.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:hexcolor/hexcolor.dart';

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
      create: (context) => RegisterUserCubit(),
      child: BlocConsumer<RegisterUserCubit, RegisterUserStates>(
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
                        'Register now to earn money with Dokantek',
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
                          isPassword: RegisterUserCubit.get(context).isPassword,
                          controller: passController,
                          suffix: RegisterUserCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterUserCubit.get(context).changeIconPass();
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
                        height: 25,
                      ),
                      state is! RegisterLoadingState
                          ? defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterUserCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                      phone: phoneController.text);
                                  navigateAndFinish(context, LoginScreen());
                                }
                              },
                              text: 'REGISTER',
                              background: HexColor('ED1B36'))
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        /* if (state is RegisterSuccesState) {
              if (state.registerModel.status!) {
                print(state.registerModel.message);
                // print(state.loginModel.data.token);
                CacheHelper.saveData(
                        key: 'token', value: state.registerModel.data!.token)
                    .then((value) {
                  token = state.registerModel.data!.token;
                  navigateAndFinish(context, LoginScreen());
                });
              } else {
                showToast(
                    text: state.registerModel.message!, state: ToastStates.e);
                print(state.registerModel.message);
              }
            } */
      }),
    );
  }
}
