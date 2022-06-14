// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/user/profile_model.dart';
import 'package:g_project/modules/user/more_screen/profilemenu.dart';
import 'package:g_project/modules/user/profile/edit_profile.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/network/end_points.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
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
            actions: [
              TextButton(
                  onPressed: () {
                    navigateTo(context, ProfileEdit());
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(255, 102, 148, 218)),
                    ),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: profile(AppCubit.get(context).proModel!.data![0]),
          ));
    }, listener: (context, state) {
      if (state is AppErrorEditProfileState) {
        flutterToast(text: 'something wrong Try Again!', state: ToastStates.E);
      } else if (state is AppSuccesGetProfileState) {
        flutterToast(text: 'Changes saved', state: ToastStates.S);
      }
    });
  }

  Widget profile(Data data) {
    if (data.photo != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 130,
                width: 130,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(IMAGEPATH + data.photo!)),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileMenu(
                text: 'Name : ${data.name}',
                icon: 'assets/icons/User Icon.svg',
                c1: const Color.fromARGB(255, 0, 0, 0),
                c2: const Color.fromARGB(255, 81, 129, 183),
                i: const SizedBox(),
              ),
              ProfileMenu(
                text: 'Email : ${data.email}',
                icon: 'assets/icons/Mail.svg',
                c1: const Color.fromARGB(255, 0, 0, 0),
                c2: const Color.fromARGB(255, 193, 49, 116),
                i: const SizedBox(),
              ),
              ProfileMenu(
                text: 'Phone : ${data.mobile}',
                width: 17,
                icon: 'assets/icons/Phone.svg',
                c1: const Color.fromARGB(255, 0, 0, 0),
                c2: const Color.fromARGB(255, 76, 186, 72),
                i: const SizedBox(),
              ),
              ProfileMenu(
                text: 'Address : ${data.address}',
                width: 17,
                icon: 'assets/icons/Location point.svg',
                c1: const Color.fromARGB(255, 0, 0, 0),
                c2: const Color.fromARGB(255, 208, 158, 89),
                i: const SizedBox(),
              ),
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: const [
                    CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/7.png',
                        ),
                        backgroundColor: Colors.white),
                    /* Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: () {},
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    ) */
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Name : ${data.name}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                'Email : ${data.email}',
                style: const TextStyle(fontSize: 30),
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
}
