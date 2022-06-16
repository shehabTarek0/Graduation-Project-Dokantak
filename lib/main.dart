// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/app_layout.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/marchant_layout.dart';
import 'package:g_project/modules/marchant/Login_mer/cubit/cubit.dart';
import 'package:g_project/modules/onboarding/onboarding_screen.dart';
import 'package:g_project/modules/splash/splash_screen.dart';
import 'package:g_project/modules/start/start.dart';
import 'package:g_project/modules/user/Login/cubit/cubit.dart';
import 'package:g_project/shared/bloc_observable.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:g_project/shared/styles/thems.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoard');
  token = CacheHelper.getData(key: 'token');
  tokenMer = CacheHelper.getData(key: 'tokenMer');

  if (onBoarding != null) {
    if (token != null) {
      widget = const AppLayout();
    } /* else if (tokenMer != null) {
      widget = const MarLayout();
    }  */
    else {
      widget = const StartScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        start: widget!,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.start,
  }) : super(key: key);
  final Widget start;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()
              ..getCategory()
              ..getProfile(),
          ),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => LoginMarCubit()),
          BlocProvider(create: (context) => MarCubit()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  home: SplashScreen(start: start),
                ),
            listener: (context, state) {}));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
