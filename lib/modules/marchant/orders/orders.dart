import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/models/merchant/orders_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarCubit, MarStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: const Text(
                'Add Products',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: buildOrders(MarCubit.get(context).orderModel),
          );
        },
        listener: (context, state) {});
  }

  Widget buildOrders(OrdersModel? orderModel) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: orderModel?.data?.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItemOrder(context, orderModel?.data![index]);
      },
    );
  }

  Widget buildItemOrder(
    context,
    Data? data,
  ) {
    return Text(data!.clientName!);
  }
}
