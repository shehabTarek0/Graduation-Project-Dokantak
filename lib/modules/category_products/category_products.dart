// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/Products_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({Key? key}) : super(key: key);
  List<String> str = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: const Text(
            'Category Products',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 2.5,
            ),
          ),
        ),
        body: buildCategoryP(
            context, AppCubit.get(context).categoryProductsModel!),
      );
    }, listener: (context, state) {
      if (state is AppSuccesChangeFavouritesState) {
        flutterToast(text: 'Succes op', state: ToastStates.S);
      }
    });
  }

  Widget buildCategoryP(context, CategoryProductsModel model) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                buildCategoryDetails0(context, model.data![0]),
                const SizedBox(
                  width: 10,
                ),
                buildCategoryDetails0(context, model.data![1]),
              ],
            ),
            Row(
              children: [
                buildCategoryDetails0(context, model.data![2]),
                const SizedBox(
                  width: 10,
                ),
                buildCategoryDetails1(context, model.data![3]),
              ],
            ),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              crossAxisSpacing: 10,
              // mainAxisSpacing: 1,
              childAspectRatio: 1 / 2.19,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.length - 4,
                (index) =>
                    buildCategoryDetails(context, model.data![index + 4]),
              ),
            )
          ],
        ));
  }

  Widget buildCategoryDetails(BuildContext context, Dataa data) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'prodectsDeteails', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage("${data.photo}"),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            '${data.price} EGY',
                            // textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                color: HexColor('ED1B36')),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 64,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isFavourite
                                      ? const Color(0xFFFFE6E6)
                                      : const Color(0xFFF5F6F9),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeF(data.id!);
                                      AppCubit.get(context)
                                          .changeFavourites(data.id!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 27,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: defaultButton(
                      function: () {
                        // ignore: deprecated_member_use
                        String encodeData = Dataa.encode([
                          Dataa(
                              id: data.id,
                              photo: data.photo,
                              price: data.price,
                              productName: data.productName)
                        ]);
                        str.add(encodeData);
                        CacheHelper.saveData(key: 'products', value: str);
                        // print(str.length);
                        CacheHelper.saveData(key: 'pro', value: encodeData);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      width: 170,
                      height: 40,
                      radius: 8),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildCategoryDetails0(BuildContext context, Dataa data) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'prodectsDeteails', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          width: 199,
          height: 385,
          margin: const EdgeInsets.only(top: 10, bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage("${data.photo}"),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            '${data.price} EGY',
                            // textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                color: HexColor('ED1B36')),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 64,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isFavourite
                                      ? const Color(0xFFFFE6E6)
                                      : const Color(0xFFF5F6F9),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeF(data.id!);
                                      AppCubit.get(context)
                                          .changeFavourites(data.id!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 27,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: defaultButton(
                      function: () {
                        // ignore: deprecated_member_use
                        String encodeData = Dataa.encode([
                          Dataa(
                              id: data.id,
                              photo: data.photo,
                              price: data.price,
                              productName: data.productName)
                        ]);
                        str.add(encodeData);
                        CacheHelper.saveData(key: 'products', value: str);
                        // print(str.length);
                        CacheHelper.saveData(key: 'pro', value: encodeData);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      width: 170,
                      height: 40,
                      radius: 8),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildCategoryDetails1(BuildContext context, Dataa data) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'prodectsDeteails', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          width: 199,
          height: 385,
          margin: const EdgeInsets.only(top: 10, bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage("${data.photo}"),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            '${data.price} EGY',
                            // textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                color: HexColor('ED1B36')),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 64,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isFavourite
                                      ? const Color(0xFFFFE6E6)
                                      : const Color(0xFFF5F6F9),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeF(data.id!);
                                      AppCubit.get(context)
                                          .changeFavourites(data.id!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 27,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: defaultButton(
                      function: () {
                        // ignore: deprecated_member_use
                        String encodeData = Dataa.encode([
                          Dataa(
                              id: data.id,
                              photo: data.photo,
                              price: data.price,
                              productName: data.productName)
                        ]);
                        str.add(encodeData);
                        CacheHelper.saveData(key: 'products', value: str);
                        // print(str.length);
                        CacheHelper.saveData(key: 'pro', value: encodeData);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      width: 170,
                      height: 40,
                      radius: 8),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildCategoryDetails2(BuildContext context, Dataa data) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'prodectsDeteails', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          width: 199,
          height: 385,
          margin: const EdgeInsets.only(top: 10, bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage("${data.photo}"),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            '${data.price} EGY',
                            // textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                color: HexColor('ED1B36')),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 64,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isFavourite
                                      ? const Color(0xFFFFE6E6)
                                      : const Color(0xFFF5F6F9),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeF(data.id!);
                                      AppCubit.get(context)
                                          .changeFavourites(data.id!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 27,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: defaultButton(
                      function: () {
                        // ignore: deprecated_member_use
                        String encodeData = Dataa.encode([
                          Dataa(
                              id: data.id,
                              photo: data.photo,
                              price: data.price,
                              productName: data.productName)
                        ]);
                        str.add(encodeData);
                        CacheHelper.saveData(key: 'products', value: str);
                        // print(str.length);
                        CacheHelper.saveData(key: 'pro', value: encodeData);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      width: 170,
                      height: 40,
                      radius: 8),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildCategoryDetails3(BuildContext context, Dataa data) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'prodectsDeteails', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          width: 199,
          height: 385,
          margin: const EdgeInsets.only(top: 10, bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage("${data.photo}"),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            '${data.price} EGY',
                            // textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                color: HexColor('ED1B36')),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 64,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isFavourite
                                      ? const Color(0xFFFFE6E6)
                                      : const Color(0xFFF5F6F9),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeF(data.id!);
                                      AppCubit.get(context)
                                          .changeFavourites(data.id!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.grey,
                                      size: 27,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: defaultButton(
                      function: () {
                        // ignore: deprecated_member_use
                        String encodeData = Dataa.encode([
                          Dataa(
                              id: data.id,
                              photo: data.photo,
                              price: data.price,
                              productName: data.productName)
                        ]);
                        str.add(encodeData);
                        CacheHelper.saveData(key: 'products', value: str);
                        // print(str.length);
                        CacheHelper.saveData(key: 'pro', value: encodeData);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      width: 170,
                      height: 40,
                      radius: 8),
                )
              ],
            ),
          ),
        ));
  }
}


/**
  GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          crossAxisSpacing: 10,
          // mainAxisSpacing: 1,
          childAspectRatio: 1 / 2.19,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            model.data!.length,
            (index) => buildCategoryDetails(context, model.data![index]),
          ),
        )
 */