import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                'Orders',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: buildOrders(MarCubit.get(context).orderModel),
                physics: const BouncingScrollPhysics()),
          );
        },
        listener: (context, state) {});
  }

  Widget buildOrders(OrdersModel? orderModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Product Orders',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderModel?.data?.length,
          itemBuilder: (BuildContext context, int index) {
            return buildItemOrder(context, orderModel!.data![index]);
          },
        ),
      ],
    );
  }

  Widget buildItemOrder(
    context,
    Data data,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 229, 232, 239),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client Name : ${data.clientName!}',
                    style: const TextStyle(fontSize: 18),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Client Address : ${data.newAddress!}',
                    style: const TextStyle(fontSize: 18),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Mobile Phone	: ${data.clientPhone!}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Total Price : ${data.total!}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: SvgPicture.asset(
                'assets/icons/Shop Icon.svg',
                color: const Color.fromARGB(255, 54, 150, 182),
                width: 30,
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
