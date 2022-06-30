// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/user/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/styles/colors.dart';

import '../../../models/user/favourite_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          if (AppCubit.get(context).favModel!.data!.isNotEmpty &&
              AppCubit.get(context).categoryProductsModel != null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'Favourites',
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
                    buildFav(context, AppCubit.get(context).favModel!),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: defaultButton(
                          function: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete Product'),
                                    content: const Text(
                                        'Do You Want To Delete wishlist'),
                                    actions: [
                                      defaultTextButton(
                                          text: 'yes',
                                          onPress: () {
                                            AppCubit.get(context).deleteFav();
                                            Navigator.pop(context);
                                          }),
                                      defaultTextButton(
                                          text: 'No',
                                          onPress: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                });
                          },
                          text: 'delete all',
                          background: Colors.red),
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
                  'My Favourite',
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
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        FontAwesome5.heart_broken,
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
                        'No Products in Favourite',
                        style: TextStyle(fontSize: 25, color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        listener: (context, state) {});
  }

  Widget buildFav(context, FavouritesModel favouritesModel) => Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favouritesModel.data!.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 0,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return buildFavItem(context, favouritesModel.data![index],
                  AppCubit.get(context).categoryProductsModel!.data![0]);
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  Widget buildFavItem(context, Data fmodel, Dataa data) => GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'proo', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage('${fmodel.photo}'),
                        fit: BoxFit.cover,
                        width: 160,
                        height: 160),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${fmodel.productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text(
                                '${fmodel.price}',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                defaultButton(
                    function: () {
                      productID.add(data.id!);
                      productNames.add(data.productName!);
                      productPrices.add(data.price!);
                      productImages.add(data.photo!);
                    },
                    text: 'ADD TO CART',
                    background: secondColor,
                    width: double.infinity,
                    height: 40,
                    radius: 7)
              ],
            ),
          ),
        ),
      );
}
