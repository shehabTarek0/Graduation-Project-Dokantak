import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/modules/Login/cubit/cubit.dart';
import 'package:g_project/modules/Login/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
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

  Widget profile(Data data) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  /* CircleAvatar(
                    radius: 0,
                    child: Image.network(
                      'url',
                      fit: BoxFit.cover,
                    ),
                  ), */
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
