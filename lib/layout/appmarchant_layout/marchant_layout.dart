import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';

class MarLayout extends StatelessWidget {
  const MarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarCubit, MarStates>(
        builder: (context, state) {
          return Scaffold(
            body: MarCubit.get(context)
                .bottomScreen[MarCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: const Color.fromARGB(255, 93, 62, 194),
              onTap: (index) {
                MarCubit.get(context).changeBottom(index);
              },
              currentIndex: MarCubit.get(context).currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_sharp, size: 29), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store, size: 30), label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_sharp, size: 29),
                    label: 'Orders'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesome5.bars), label: 'More')
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
