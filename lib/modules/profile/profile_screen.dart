import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              body: profile());
        },
        listener: (context, state) {});
  }

  Widget profile() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Image.asset(
                      'assets/images/w.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'name',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const Text(
                'phone',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text(
                'address',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      );
}
