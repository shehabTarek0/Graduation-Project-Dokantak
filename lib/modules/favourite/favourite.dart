import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/Favourite_model.dart';
import 'package:g_project/models/data.dart';
import 'package:g_project/modules/product_details/product_details.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            elevation: 2,
            centerTitle: true,
            title: const Text(
              'Favourites',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ),
          body: buildFav(context, AppCubit.get(context).favModel!));
    }, listener: (context, state) {
      if (state is AppErrorChangeFavouritesState) {
        flutterToast(text: 'eee', state: ToastStates.S);
      }
    });
  }

  Widget buildFav(context, FavouritesModel favouritesModel) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: favouritesModel.data!.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return buildFavItem(context, favouritesModel.data![index],
              AppCubit.get(context).categoryProductsModel!.data![0]);
        },
      );

  Widget buildFavItem(context, Data fmodel, Dataa data) => GestureDetector(
        onTap: () {
          String encodeDataa = Dataa.encode([
            Dataa(
                id: data.id,
                photo: data.photo,
                price: data.price,
                productName: data.productName)
          ]);
          CacheHelper.saveData(key: 'proo', value: encodeDataa);
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
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage('${fmodel.photo}'),
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
                            '${fmodel.productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.6,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text(
                                '${fmodel.price}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                    color: HexColor('ED1B36')),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 64,
                                    decoration: BoxDecoration(
                                      color: AppCubit.get(context).isFavourite
                                          ? const Color(0xFFFFE6E6)
                                          : const Color(0xFFF5F6F9),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          AppCubit.get(context)
                                              .changeF(fmodel.id!);
                                          AppCubit.get(context)
                                              .changeFavourites(fmodel.id!);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.grey,
                                          size: 27,
                                        ))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                defaultButton(
                    // ignore: avoid_returning_null_for_void
                    function: () => null,
                    text: 'ADD TO CART',
                    background: secondColor,
                    width: double.infinity,
                    height: 40,
                    radius: 7)
              ],
            ),
          ),
        ),
      );
}
