import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/marchant_layout.dart';
import 'package:g_project/shared/component/component.dart';

import '../../../layout/appmarchant_layout/cubit/cubit.dart';
import '../../../layout/appmarchant_layout/cubit/states.dart';
import '../../../shared/component/constants.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<MarCubit, MarStates>(builder: ((context, state) {
      if (MarCubit.get(context).allProducts != null) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            centerTitle: true,
            title: const Text(
              'Add Category',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    text: 'Category Name',
                    controller: catController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'please enter your Product Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          MarCubit.get(context).addCategory(catController.text);
                        }
                      },
                      text: 'Add Category',
                      isUpperCase: false,
                      background: const Color.fromARGB(255, 86, 127, 113),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 255, 254, 254)))
                ],
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
                'Add Category',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()));
      }
    }), listener: (context, state) {
      if (state is MarSuccesAddCategoryState) {
        catController.text = '';
        MarCubit.get(context).getMerCategory();
        navigateAndFinish(context, const MarLayout());
        return flutterToast(
            text: 'Category added successfully', state: ToastStates.S);
      }
    });
  }
}
