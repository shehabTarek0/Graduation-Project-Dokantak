// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../layout/app_layout/cubit/cubit.dart';
import '../../../shared/component/constants.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails(Type dataa, {Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          centerTitle: true,
          title: const Text(
            'Product Details',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 2.5,
            ),
          ),
        ),
        body: bulidProductDetails(context),
      );
    }, listener: (context, state) {
      if (state is AppSuccesChangeFavouritesState) {
        flutterToast(
            text: 'Product added to favourite successfully',
            state: ToastStates.S);
      }
    });
  }

  Widget bulidProductDetails(context) {
    String getProo = CacheHelper.getData(key: 'prodectsDetailsInSearch');
    List<Dataa> decc = Dataa.decode(getProo);
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: NetworkImage('${decc[0].photo}'),
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name : ${decc[0].productName}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        height: 1.5,
                        letterSpacing: 0.6),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('Price : ${decc[0].price}',
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.6)),
                      const Text('\$',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.6)),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${decc[0].description}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.2),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      function: () {
                        AppCubit.get(context).changeFavourites(decc[0].id!);
                      },
                      text: 'ADD TO Favourite',
                      background: const Color.fromARGB(234, 231, 22, 7),
                      height: 40,
                      radius: 8),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      function: () {
                        productID.add(decc[0].id!);
                        productNames.add(decc[0].productName!);
                        productPrices.add(decc[0].price!);
                        productImages.add(decc[0].photo!);
                        flutterToast(
                            text: 'Product added successfully',
                            state: ToastStates.S);
                      },
                      text: 'ADD TO CART',
                      background: HexColor('#7A92A3'),
                      height: 40,
                      radius: 8),
                ],
              ),
            ),
          ],
        ));
  }

  Widget userReviews() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.asset(
                  'assets/images/w.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Shehab Tarek',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.star_outlined,
                color: Colors.amber,
                size: 25,
              ),
              Icon(
                Icons.star_outlined,
                color: Colors.amber,
                size: 25,
              ),
              Icon(
                Icons.star_outlined,
                color: Colors.amber,
                size: 25,
              ),
              Icon(
                Icons.star_half_outlined,
                color: Colors.amber,
                size: 25,
              ),
              Icon(
                Icons.star_border,
                color: Colors.amber,
                size: 25,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 7),
            child: Text(
              'Shehab Tarek Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek Shehab Tarek ',
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: 0.2),
            ),
          ),
        ],
      );
}
