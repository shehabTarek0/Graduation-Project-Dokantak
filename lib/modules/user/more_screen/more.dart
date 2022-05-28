import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/modules/start/start.dart';
import 'package:g_project/modules/user/changepass/changepass.dart';
import 'package:g_project/modules/user/favourite/favourite.dart';
import 'package:g_project/modules/user/more_screen/profilemenu.dart';
import 'package:g_project/modules/user/profile/profile_screen.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      profilePic(
                          context, AppCubit.get(context).proModel!.data![0]),
                      const SizedBox(height: 20),
                      ProfileMenu(
                        text: "My Account",
                        icon: "assets/icons/User.svg",
                        c1: const Color.fromARGB(221, 26, 22, 22),
                        c2: const Color.fromARGB(209, 46, 34, 171),
                        press: () =>
                            {navigateTo(context, const ProfileScreen())},
                      ),
                      ProfileMenu(
                        text: "Favourite",
                        icon: "assets/icons/Heart Icon_2.svg",
                        c1: const Color.fromARGB(221, 26, 22, 22),
                        c2: const Color.fromARGB(224, 243, 27, 27),
                        press: () {
                          AppCubit.get(context).getFavourites();
                          navigateTo(context, const FavouriteScreen());
                        },
                      ),
                      ProfileMenu(
                        text: "Change Password",
                        icon: "assets/icons/Lock.svg",
                        c1: const Color.fromARGB(221, 26, 22, 22),
                        c2: const Color.fromARGB(223, 45, 243, 27),
                        press: () => {navigateTo(context, ChangePass())},
                      ),
                      ProfileMenu(
                        text: "Log Out",
                        icon: "assets/icons/Log out.svg",
                        c1: const Color.fromARGB(221, 26, 22, 22),
                        c2: const Color.fromARGB(223, 136, 174, 176),
                        press: () => {
                          CacheHelper.removeData(key: 'token').then((value) {
                            if (value) {
                              AppCubit.get(context).currentIndex = 0;
                              emailController.text = '';
                              passController.text = '';
                              navigateAndFinish(context, const StartScreen());
                            }
                          })
                        },
                      ),
                    ],
                  ),
                ),
              ));
        },
        listener: (context, state) {});
  }

  Widget profilePic(context, Data data) {
    if (data.photo != null) {
      return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://care.ssd-co.com/storage/app/public/${data.photo}',
                  scale: 90),
            ),
            Positioned(
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
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/7.png',
                ),
                backgroundColor: Colors.white),
            Positioned(
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
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
