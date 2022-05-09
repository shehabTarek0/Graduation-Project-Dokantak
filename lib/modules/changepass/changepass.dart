import 'package:flutter/material.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/styles/colors.dart';

class ChangePass extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  ChangePass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentPassController = TextEditingController();
    var newPassController = TextEditingController();
    var verifyNewPassController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                defaultFormField(
                  text: 'Current password',
                  controller: currentPassController,
                  type: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'please enter your current password';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  text: 'New password',
                  controller: newPassController,
                  type: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'please enter your New password';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  text: 'Verify New password',
                  controller: verifyNewPassController,
                  type: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'please veirfy New password';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 60,
                ),
                defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        if (newPassController.text ==
                            verifyNewPassController.text) {
                          navigateTo(context, const CartScreen());
                        }
                      }
                    },
                    text: 'Save',
                    background: secondColor,
                    isUpperCase: false,
                    style: const TextStyle(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
