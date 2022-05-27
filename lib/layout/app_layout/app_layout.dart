import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => Scaffold(
              body: AppCubit.get(context)
                  .bottomScreen[AppCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                fixedColor: const Color.fromARGB(255, 93, 62, 194),
                onTap: (index) {
                  AppCubit.get(context).changeBottom(index);
                },
                currentIndex: AppCubit.get(context).currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_sharp, size: 29), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesome5.store_alt), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesome5.shopping_cart,
                      ),
                      label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesome5.bars), label: 'More')
                ],
              ),
            ),
        listener: (context, state) {});
  }
}
