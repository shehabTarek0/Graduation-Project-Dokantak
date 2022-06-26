import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/models/merchant/all_products_model.dart';
import 'package:g_project/modules/marchant/add_product/add_product.dart';
import 'package:g_project/modules/marchant/edit_product/edit_product.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';

class MarHome extends StatelessWidget {
  const MarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarCubit, MarStates>(
        builder: ((context, state) {
          if (MarCubit.get(context).allProducts != null) {
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
              body: buildPro(MarCubit.get(context).allProducts!),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    productNameController.text = '';
                    productPriceController.text = '';
                    productDesController.text = '';
                    idc = '';
                    imageProduct = null;
                    navigateTo(context, const AddProduct());
                  },
                  child: const Icon(Icons.add)),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  elevation: 2,
                  title: const Text(
                    'My Products',
                    style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        }),
        listener: (context, state) {});
  }

  Widget buildPro(AllProductsModel allProducts) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: allProducts.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return buildProItem(context, allProducts.data![index]);
      },
    );
  }

  Widget buildProItem(context, Data data) {
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
                  Image(
                      image: NetworkImage(data.photo!),
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
                          data.productName!,
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
                        Text(
                          '${data.price} LE',
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Description : ${data.description}',
                          maxLines: 1,
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
                      function: () {
                        productNameController.text = data.productName!;
                        productPriceController.text = data.price!;
                        productDesController.text = data.description!;
                        idc = '${data.categoryId!}';
                        navigateTo(context, EditProduct(data.id!));
                      },
                      text: 'Edit',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      background: const Color.fromARGB(255, 14, 181, 153),
                      width: 180,
                      height: 50,
                      radius: 7),
                  const Spacer(),
                  defaultButton(
                      // ignore: avoid_returning_null_for_void
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => alert(context, data.id));
                      },
                      text: 'Delete',
                      background: const Color.fromARGB(255, 209, 0, 0),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      width: 180,
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

  Widget alert(
    context,
    int? id,
  ) {
    {
      return AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Do You Want To Delete Product'),
        actions: [
          defaultTextButton(
              text: 'yes',
              onPress: () {
                MarCubit.get(context).deleteProduct(id!);
                MarCubit.get(context).getAllProducts();
                Navigator.pop(context);
              }),
          defaultTextButton(
              text: 'No',
              onPress: () {
                Navigator.pop(context);
              })
        ],
      );
    }
  }
}
