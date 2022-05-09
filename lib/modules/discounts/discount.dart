import 'package:flutter/material.dart';
import 'package:g_project/modules/Cart/cart.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:hexcolor/hexcolor.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Mounth Discount',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          crossAxisSpacing: 10,
          // mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.77,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(10, (index) => gridProductsBuilder(context)),
        ),
      ),
    );
  }

  gridProductsBuilder(context) => GestureDetector(
      onTap: () => navigateTo(context, const CartScreen()),
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
      ));
}
