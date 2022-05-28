import 'package:flutter/material.dart';
import 'package:g_project/modules/marchant/add_product/add_product.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/styles/colors.dart';

class MarHome extends StatelessWidget {
  const MarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'My Products',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: buildPro(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(context, const AddProduct());
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget buildPro() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return buildProItem();
      },
    );
  }

  Widget buildProItem() {
    return GestureDetector(
      onTap: () {
/*           String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'proo', value: encodeDataa);
          navigateTo(context, ProductDetails(Dataa)); */
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
                  const Image(
                      image: AssetImage('assets/images/AlluringRug.png'),
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
                          'basket',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.6,
                              color: Colors.grey[800]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '100 LE',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Seller Name : Shehab',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.6,
                              color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  defaultButton(
                      // ignore: avoid_returning_null_for_void
                      function: () => null,
                      text: 'Edit',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      background: const Color.fromARGB(255, 14, 181, 153),
                      width: 160,
                      height: 50,
                      radius: 7),
                  const Spacer(),
                  defaultButton(
                      // ignore: avoid_returning_null_for_void
                      function: () => null,
                      text: 'Delete',
                      background: const Color.fromARGB(255, 209, 0, 0),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      width: 160,
                      height: 50,
                      radius: 7),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
