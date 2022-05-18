// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: profile(AppCubit.get(context).proModel!.data![0]));
        },
        listener: (context, state) {});
  }

  Widget profile(Data data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://care.ssd-co.com/storage/app/public/${data.photo}' ==
                              null
                          ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                          : 'https://care.ssd-co.com/storage/app/public/${data.photo}',
                      scale: 90),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  '${data.name}',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Text(
              '${data.mobile}',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              '${data.address}',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
