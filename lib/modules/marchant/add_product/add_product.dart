import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/layout/appmarchant_layout/marchant_layout.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productNameController = TextEditingController();
    final productPriceController = TextEditingController();
    final productDesController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    List<dynamic> categories =
        MarCubit.get(context).category!.toJson().entries.elementAt(1).value;
    String? idc;

    return BlocConsumer<MarCubit, MarStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: const Text(
                'Add Products',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultFormField(
                        text: 'Product Name',
                        controller: productNameController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'please enter your Product Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      defaultFormField(
                        text: 'Price',
                        controller: productPriceController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'please enter your Product Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      defaultFormField(
                          text:
                              'Description (Shop Name , phone number , Address , Product description)',
                          controller: productDesController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your Product Name';
                            }
                            return null;
                          },
                          numOfLines: 5),
                      const SizedBox(height: 30),
                      FormHelper.dropDownWidget(
                          context, 'Select Category Type', idc, categories,
                          (on) {
                        idc = on;
                      }, (val) {
                        if (val == null) {
                          return 'please select Category';
                        }
                        return null;
                      },
                          borderColor: Colors.black,
                          borderRadius: 10,
                          borderWidth: 10,
                          paddingLeft: 0,
                          paddingRight: 0,
                          hintFontSize: 17,
                          contentPadding: 10,
                          borderFocusColor: Colors.grey,
                          textColor: Colors.black),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          defaultButton(
                              function: () {
                                MarCubit.get(context).getImage();
                              },
                              text: 'Choose photo',
                              height: 60,
                              width: 170,
                              isUpperCase: false,
                              background: Colors.grey[400],
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 20)),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: 180,
                            child: TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: imageProduct?.path.split('/').last,
                              ),
                              enabled: false,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              DioHelper().uploadImage(
                                  url:
                                      'https://care.ssd-co.com/api/admin/product',
                                  file: imageProduct!,
                                  data: {
                                    'Product_name': productNameController.text,
                                    'description': productDesController.text,
                                    'photo': await MultipartFile.fromFile(
                                        imageProduct!.path,
                                        filename:
                                            imageProduct!.path.split('/').last),
                                    'price': productPriceController.text,
                                    'category_id': idc
                                  }).then((value) {
                                flutterToast(
                                    text: 'Product Upload Successfully',
                                    state: ToastStates.S);
                                MarCubit.get(context).getAllProducts();
                                productNameController.text = '';
                                productDesController.text = '';
                                imageProduct = null;
                                productPriceController.text = '';
                                idc = null;
                                navigateAndFinish(context, const MarLayout());
                              });
                            }
                          },
                          text: 'Add Product',
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
        },
        listener: (context, state) {});
  }
}
