// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          if (getPro == null &&
              getProduct0 == null &&
              getProduct1 == null &&
              getProduct2 == null &&
              getProduct3 == null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'My Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        FontAwesome5.cart_arrow_down,
                        size: 150,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'No Products in Cart',
                        style: TextStyle(fontSize: 25, color: Colors.grey[400]),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'My Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: [
                        AppCubit.get(context).buildCartItem(
                            context,
                            AppCubit.get(context)
                                .categoryProductsModel!
                                .data![0]),
                        AppCubit.get(context).buildCartItem0(
                            context,
                            AppCubit.get(context)
                                .categoryProductsModel!
                                .data![0]),
                        AppCubit.get(context).buildCartItem1(
                            context,
                            AppCubit.get(context)
                                .categoryProductsModel!
                                .data![0]),
                        AppCubit.get(context).buildCartItem2(
                            context,
                            AppCubit.get(context)
                                .categoryProductsModel!
                                .data![0]),
                        AppCubit.get(context).buildCartItem3(
                            context,
                            AppCubit.get(context)
                                .categoryProductsModel!
                                .data![0]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '4 Products',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 17),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Total: 1 LE',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          defaultButton(
                              function: () {},
                              text: 'Check Out',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              background: HexColor('#FFBC35'),
                              width: 150,
                              isUpperCase: false,
                              radius: 7)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
        listener: (context, state) {});
  }
}
