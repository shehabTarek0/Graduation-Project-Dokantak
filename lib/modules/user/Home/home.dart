import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/user/category_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/models/user/products_model.dart';
import 'package:g_project/modules/user/Cart/cart.dart';
import 'package:g_project/modules/user/categories/categories.dart';
import 'package:g_project/modules/user/category_products/category_products.dart';
import 'package:g_project/modules/user/product_details/product_details.dart';
import 'package:g_project/modules/user/search/search_screen.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          if (AppCubit.get(context).categoryModel != null &&
              AppCubit.get(context).categoryProductsModelHome != null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: IconButton(
                        onPressed: () =>
                            navigateTo(context, const SearchScreen()),
                        icon: const Icon(
                          FontAwesome5.search,
                          size: 22,
                        )),
                  )
                ],
                title: const Text(
                  'DOKANTAK',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: prouductBlider(
                  context,
                  AppCubit.get(context).categoryModel!,
                  AppCubit.get(context).categoryProductsModelHome!),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  elevation: 2,
                  actions: [
                    IconButton(
                        onPressed: () =>
                            navigateTo(context, const SearchScreen()),
                        icon: const Icon(
                          FontAwesome5.search,
                          size: 22,
                        ))
                  ],
                  title: const Text('DOKANTAK',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.5,
                      )),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        },
        listener: (context, state) {});
  }

  Widget prouductBlider(context, CategoryClassModel categoryClassModel,
          CategoryProductsModel categoryProductsModel) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: [
                  GestureDetector(
                    onTap: () => {navigateTo(context, const CartScreen())},
                    child: const Image(
                      image: AssetImage('assets/images/s1.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => navigateTo(context, const CartScreen()),
                    child: const Image(
                      image: AssetImage('assets/images/s2.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => navigateTo(context, const CartScreen()),
                    child: const Image(
                      image: AssetImage('assets/images/s3.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => navigateTo(context, const CartScreen()),
                    child: const Image(
                      image: AssetImage('assets/images/s4.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  defaultTextButton(
                      onPress: () =>
                          navigateTo(context, const CategoryScreen()),
                      text: 'View All',
                      style: TextStyle(color: mainColor, fontSize: 16))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryClassModel.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    List<String> images = [
                      'assets/images/gf.jpg',
                      'assets/images/wqw.jpg',
                      'assets/images/re.jpg',
                      'assets/images/down.jpg',
                      'assets/images/38252837.jpg',
                      'assets/images/images.png',
                      'assets/images/ba.webp',
                      'assets/images/38252837.jpg',
                      'assets/images/38252837.jpg',
                    ];
                    return categoriesBulider(context,
                        categoryClassModel.data![index], images[index]);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              crossAxisSpacing: 10,
              // mainAxisSpacing: 1,
              childAspectRatio: 1 / 2.24,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  10,
                  (index) => gridProductsBuilder(
                      context, categoryProductsModel.data![index])),
            ),
          ],
        ),
      );

  categoriesBulider(context, Data data, String imag) => GestureDetector(
        onTap: () {
          AppCubit.get(context).getCategoryProducts(data.id!);
          navigateTo(context, const CategoryProducts());
        },
        child: Column(
          children: [
            Image(
              image: AssetImage(imag),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            Text(
              data.name!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  gridProductsBuilder(context, Dataa param1) => GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: param1.id,
                photo: param1.photo,
                price: param1.price,
                productName: param1.productName,
                description: param1.description),
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
          child: Column(
            children: [
              Image(
                image: NetworkImage(param1.photo!),
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      param1.productName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                          color: Colors.grey[800]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${param1.price} LE',
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
                height: 15,
              ),
              defaultButton(
                  function: () {
                    AppCubit.get(context).changeFavourites(param1.id!);
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
                    productID.add(param1.id!);
                    productNames.add(param1.productName!);
                    productPrices.add(param1.price!);
                    productImages.add(param1.photo!);
                    flutterToast(
                        text: 'Product added successfully',
                        state: ToastStates.S);
                  },
                  text: 'ADD TO CART',
                  background: HexColor('#7A92A3'),
                  width: 170,
                  height: 40,
                  radius: 8)
            ],
          ),
        ),
      );
}
