// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/models/profile_model.dart';
import 'package:g_project/shared/network/end_points.dart';

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
    if (data.photo != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${IMAGEPATH}${data.photo}',
                              scale: 90)),
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
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      )
                    ],
                  ),
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
                  'Phone : ${data.mobile}',
                  style: const TextStyle(fontSize: 30),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Location',
                    style: const TextStyle(color: Colors.blue, fontSize: 30),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        /*  // MapUtils.openmap(31.230031500928717, 29.98739952423728);
                        const url =
                            'comgooglemaps://?center=31.230031500928717, 29.98739952423728';
                        final urll =
                            Uri.https('maps.app.goo.gl', 'W9Y7U1okaCL8TEy26');
                        if (await canLaunchUrlString(url)) {
                          // await launchUrl(urll);
                          await launch(url,
                              forceWebView: true, enableJavaScript: true);
                        } */
                      },
                  ),
                ]))
              ],
            ),
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
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
