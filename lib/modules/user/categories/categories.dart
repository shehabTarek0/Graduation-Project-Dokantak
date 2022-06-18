// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/user/category_model.dart';
import 'package:g_project/modules/user/category_products/category_products.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          if (AppCubit.get(context).categoryModel != null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: Container(
                color: HexColor('f9f9f9'),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: AppCubit.get(context).categoryModel!.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    List<String> images = [
                      'assets/images/Basket.png',
                      'assets/images/AlluringRug.png',
                      'assets/images/12.png',
                      'assets/images/Vaso-gen.png',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
                    ];
                    return buildCatItem(
                        context,
                        AppCubit.get(context).categoryModel!.data![index],
                        images[index]);
                  },
                ),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  elevation: 2,
                  centerTitle: true,
                  title: const Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        },
        listener: (context, state) {});
  }

  Widget buildCatItem(
    BuildContext context,
    Data data,
    String imag,
  ) =>
      GestureDetector(
        onTap: () {
          AppCubit.get(context).getCategoryProducts(data.id!);
          navigateTo(context, const CategoryProducts());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 12, top: 5, bottom: 5),
            child: Row(
              children: [
                Image(
                  image: AssetImage(imag),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  data.name!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      );
}
