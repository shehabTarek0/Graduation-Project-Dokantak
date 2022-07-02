import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/app_layout.dart';

import '../../../layout/app_layout/cubit/cubit.dart';
import '../../../layout/app_layout/cubit/states.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      if (AppCubit.get(context).allPrice() != 0.0) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            centerTitle: true,
            title: const Text(
              'Check out',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultFormField(
                      text: 'Name',
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      text: 'Mobile phone',
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter your Mobile phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      text: 'Address',
                      controller: addressController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter your Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'TOTAL : ${AppCubit.get(context).allPrice()}\$',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            AppCubit.get(context).postCheckOut(
                                nameController.text,
                                phoneController.text,
                                addressController.text);
                          }
                        },
                        text: 'Check Out',
                        isUpperCase: false,
                        background: const Color.fromARGB(255, 86, 127, 113),
                        style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 255, 254, 254)))
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: const Text(
                'Check out',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()));
      }
    }, listener: (context, state) {
      if (state is AppSuccesCheckOutState) {
        nameController.text = '';
        phoneController.text = '';
        addressController.text = '';
        productID.clear();
        productImages.clear();
        productNames.clear();
        productPrices.clear();
        navigateAndFinish(context, const AppLayout());
        return flutterToast(
            text: 'The Order added successfully', state: ToastStates.S);
      }
    });
  }
}
