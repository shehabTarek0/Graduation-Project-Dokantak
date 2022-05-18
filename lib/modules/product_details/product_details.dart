// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails(Type dataa, {Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
  }

  Widget bulidProductDetails(context) {
    String getProo = CacheHelper.getData(key: 'prodectsDeteails');
    List<Dataa> decc = Dataa.decode(getProo);
    var commController = TextEditingController();
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
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${decc[0].productName}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        height: 1.5,
                        letterSpacing: 0.6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('${decc[0].price}',
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  letterSpacing: 0.6)),
                          const Text('EGP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  letterSpacing: 0.6)),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            '400',
                            maxLines: 1,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                          const Text('EGP',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  letterSpacing: 0.6)),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  navigateTo(context, CartScreen());
                                },
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.grey,
                                  size: 27,
                                ))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Quantity: ',
                        style: TextStyle(
                          letterSpacing: 0.6,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.grey,
                                width: 0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: HexColor('ED1B36'),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesome5.minus,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                              backgroundColor: HexColor('#55CE63'),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesome5.plus,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                  const Text(
                    'Customer ratings',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '3.6 out of 5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    '7 global ratings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Customer reviews',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 12),
                        child: Container(
                          color: Colors.grey[500],
                          width: double.infinity,
                          height: 1,
                        ),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return userReviews();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Add your review',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultFormField(
                            text: 'Add comment',
                            numOfLines: 4,
                            controller: commController,
                            type: TextInputType.multiline,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'The comment is empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultButton(
                              function: () {},
                              text: 'Add Comment',
                              width: 180,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                              background: mainColor),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
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
