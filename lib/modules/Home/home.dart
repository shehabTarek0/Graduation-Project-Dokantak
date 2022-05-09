import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/category_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/modules/categories/categories.dart';
import 'package:g_project/modules/category_products/category_products.dart';
import 'package:g_project/modules/discounts/discount.dart';
import 'package:g_project/modules/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                elevation: 2,
                actions: [
                  IconButton(
                      onPressed: () => navigateTo(context, const CartScreen()),
                      icon: const Icon(
                        FontAwesome5.search,
                        size: 22,
                      ))
                ],
                title: const Text(
                  'DOKANTAK',
                  style: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body:
                  prouductBlider(context, AppCubit.get(context).categoryModel!),
            ),
        listener: (context, state) {});
  }

  Widget prouductBlider(context, CategoryClassModel categoryClassModel) =>
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
                      'assets/images/Basket.png',
                      'assets/images/AlluringRug.png',
                      'assets/images/12.png',
                      'assets/images/Vaso-gen.png',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
                      'assets/images/accessories-icon-png-12.jpg',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Mounth Discounts',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  defaultTextButton(
                      onPress: () =>
                          navigateTo(context, const DiscountScreen()),
                      text: 'View All',
                      style: TextStyle(color: mainColor, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return disBuilder(context);
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Proudects',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              crossAxisSpacing: 10,
              // mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.77,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  List.generate(10, (index) => gridProductsBuilder(context)),
            ),
          ],
        ),
      );

  categoriesBulider(context, Data data, String imag) => GestureDetector(
        onTap: () => navigateTo(context, const CategoryProducts()),
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

  disBuilder(context) => GestureDetector(
        onTap: () => navigateTo(context, ProductDetails(Dataa)),
        child: SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/images/AlluringRug.png'),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              Text(
                'Alluring Rug',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: Colors.grey[600]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Text(
                    '300 LE',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    '350 LE',
                    maxLines: 1,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              defaultButton(
                  // ignore: avoid_returning_null_for_void
                  function: () => null,
                  text: 'ADD TO CART',
                  background: HexColor('#7A92A3'),
                  width: 130,
                  height: 40,
                  radius: 8)
            ],
          ),
        ),
      );

  gridProductsBuilder(context) => GestureDetector(
        onTap: () => navigateTo(context, ProductDetails(Dataa)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/images/AlluringRug.png'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alluring Rug',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: Colors.grey[800]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          '350 LE',
                          maxLines: 1,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Text(
                          '300 LE',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: HexColor('ED1B36')),
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
                    function: () {},
                    text: 'ADD TO CART',
                    background: HexColor('#7A92A3'),
                    width: 170,
                    height: 40,
                    radius: 8),
              )
            ],
          ),
        ),
      );
}
