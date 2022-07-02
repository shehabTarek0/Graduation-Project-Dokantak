import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';

import '../check_out/check_out.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

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
          if (AppCubit.get(context).allPrice() == 0.0) {
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
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productID.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return AppCubit.get(context).cartItem(
                          context,
                          productNames,
                          productPrices,
                          productImages,
                          index,
                          /* AppCubit.get(context)
                                .categoryProductsModel!
                                .data![index] */
                        );
                      },
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
                                '${productID.length} Products',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Total: ${AppCubit.get(context).allPrice()} LE',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          defaultButton(
                              function: () {
                                navigateTo(context, const CheckOut());
                                // AppCubit.get(context).postCheckOut();
                              },
                              text: 'Continue Shopping',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              background:
                                  const Color.fromARGB(255, 202, 149, 15),
                              width: 210,
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
