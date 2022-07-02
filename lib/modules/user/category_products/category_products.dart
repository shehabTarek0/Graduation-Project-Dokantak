import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/user/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/user/products_model.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      if (AppCubit.get(context).categoryProductsModel != null) {
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
      } else {
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
          body: const Center(child: CircularProgressIndicator()),
        );
      }
    }, listener: (context, state) {
      if (state is AppSuccesChangeFavouritesState) {
        flutterToast(
            text: 'Product added to favourite successfully',
            state: ToastStates.S);
      }
    });
  }

  Widget buildCategoryP(context, CategoryProductsModel model) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 2.24,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.length,
                (index) => buildCategoryDetails(context, model.data![index]),
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
                productName: data.productName,
                description: data.description)
          ]);
          CacheHelper.saveData(
              key: 'prodectsDetailsInSearch', value: encodeDataa);
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
                    children: [
                      Text(
                        '${data.productName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        '${data.price} LE',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                defaultButton(
                    function: () {
                      AppCubit.get(context).changeFavourites(data.id!);
                    },
                    text: 'ADD TO Favourite',
                    background: const Color.fromARGB(234, 231, 22, 7),
                    width: 170,
                    height: 40,
                    radius: 8),
                const SizedBox(
                  height: 15,
                ),
                defaultButton(
                    function: () {
                      productID.add(data.id!);
                      productNames.add(data.productName!);
                      productPrices.add(data.price!);
                      productImages.add(data.photo!);
                      flutterToast(
                          text: 'Product added successfully',
                          state: ToastStates.S);
                    },
                    text: 'ADD TO CART',
                    background: HexColor('#7A92A3'),
                    width: 170,
                    height: 40,
                    radius: 8),
              ],
            ),
          ),
        ));
  }
}
