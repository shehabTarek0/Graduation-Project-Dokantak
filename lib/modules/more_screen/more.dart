import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/modules/changepass/changepass.dart';
import 'package:g_project/modules/favourite/favourite.dart';
import 'package:g_project/modules/notification_screen/notification.dart';
import 'package:g_project/modules/profile/profile_screen.dart';
import 'package:g_project/modules/start/start.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: 720,
                  color: HexColor('f9f9f9'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vProfile(context, AppCubit.get(context).proModel),
                      GestureDetector(
                        onTap: () =>
                            navigateTo(context, const FavouriteScreen()),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesome5.heart,
                                  size: 22,
                                  color: HexColor('ED1B36'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Favourites',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            navigateTo(context, const NotificationScreen()),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesome5.bell,
                                  size: 22,
                                  color: HexColor('#7A92A3'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Notifications',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => navigateTo(context, ChangePass()),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesome5.key,
                                  size: 22,
                                  color: HexColor('#55CE63'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Change Password',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultButton(
                            text: 'log out',
                            background: mainColor,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 1),
                            function: () {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                if (value) {
                                  AppCubit.get(context).currentIndex = 0;
                                  emailController.text = '';
                                  passController.text = '';
                                  navigateAndFinish(
                                      context, const StartScreen());
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ));
        },
        listener: (context, state) {});
  }

  Widget vProfile(
    context,
    ProfileModel? proModel,
  ) =>
      GestureDetector(
          onTap: () => navigateTo(context, const ProfileScreen()),
          child: v(context, proModel!.data![0]));

  Widget v(
    context,
    Data? data,
  ) =>
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: .7,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data!.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 27),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'View Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 25,
              )
            ],
          ),
        ),
      );
}
