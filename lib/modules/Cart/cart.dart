import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return buildCartItem(context,
                    AppCubit.get(context).categoryProductsModel!.data![index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '4 Products',
                      style: TextStyle(color: Colors.grey[700], fontSize: 17),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Total: 1240 LE',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                defaultButton(
                    function: () {},
                    text: 'Check Out',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    background: HexColor('#FFBC35'),
                    width: 150,
                    isUpperCase: false,
                    radius: 7)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCartItem(context, Dataa data) {
    String getPro = CacheHelper.getData(key: 'pro');
    List<Dataa> dec = Dataa.decode(getPro);
    return GestureDetector(
      onTap: () {
        String encodeDataa = Dataa.encode([
          Dataa(
              id: data.id,
              photo: data.photo,
              price: data.price,
              productName: data.productName)
        ]);
        CacheHelper.saveData(key: 'productCard', value: encodeDataa);
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
          padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      image: NetworkImage(dec[0].photo!),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${dec[0].productName}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.6,
                              color: Colors.grey[800]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                  color: Colors.grey[600]),
                            ),
                            Text(
                              '${dec[0].price} LE',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                CacheHelper.removeData(key: 'pro');
                              },
                              icon: const Icon(FontAwesome5.trash),
                              color: HexColor('ED1B36'),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                      width: 0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesome5.minus,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 25,
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
