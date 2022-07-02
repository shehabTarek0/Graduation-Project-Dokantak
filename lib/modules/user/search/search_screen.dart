import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/s.dart';
import 'package:g_project/modules/user/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/proapi.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ignore: non_constant_identifier_names
  List<Dataa> Products = [];
  String query = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final products = await ProductApi.getProducts(query);

    setState(() => Products = products);
  }

  TextEditingController? searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                buildSearch(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: Products.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final product = Products[index];
                      return searchItem(product);
                    },
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  Future searchProduct(String query) async => debounce(() async {
        final products = await ProductApi.getProducts(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          Products = products;
        });
      });

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchProduct,
      );

  Widget searchItem(Dataa product) {
    return GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: product.id,
                photo: product.photo,
                price: product.price,
                productName: product.productName,
                description: product.description)
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
            child: Row(
              children: [
                Image(
                  image: NetworkImage("${product.photo}"),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      '${product.productName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: Colors.grey[800]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${product.price} EGY',
                      // textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: HexColor('ED1B36')),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: () {
                          productID.add(product.id!);
                          productNames.add(product.productName!);
                          productPrices.add(product.price!);
                          productImages.add(product.photo!);
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
                )
              ],
            ),
          ),
        ));
  }
}
