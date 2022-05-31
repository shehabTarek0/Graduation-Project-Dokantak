import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: editProfile(context),
          );
        },
        listener: (context, state) {});
  }

  Widget editProfile(context) {
/*     nameController.text = AppCubit.get(context).proModel!.data![0].name!;
    emailController.text = AppCubit.get(context).proModel!.data![0].email!;
    addressController.text = AppCubit.get(context).proModel!.data![0].address!; */
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    text: 'Address',
                    controller: addressController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'please enter your address';
                      }
                      return null;
                    },
                    prefix: Icons.lock_outline),

                const SizedBox(
                  height: 35,
                ),

                // state is! RegisterLoadingState
                defaultButton(
                    function: () {
                      AppCubit.get(context).profileEdit(
                          name: nameController.text,
                          email: emailController.text,
                          address: addressController.text);
                      nameController.text = '';
                      emailController.text = '';
                      addressController.text = '';
                    },
                    text: 'Save',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22),
                    background: const Color.fromARGB(255, 46, 191, 155))
                // const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
