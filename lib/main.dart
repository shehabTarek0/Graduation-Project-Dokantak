// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/app_layout/app_layout.dart';
import 'package:g_project/layout/app_layout/cubit/cubit.dart';
import 'package:g_project/layout/app_layout/cubit/states.dart';
import 'package:g_project/modules/Login/cubit/cubit.dart';
import 'package:g_project/modules/onboarding/onboarding_screen.dart';
import 'package:g_project/modules/splash/splash_screen.dart';
import 'package:g_project/modules/start/start.dart';
import 'package:g_project/shared/bloc_observable.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:g_project/shared/network/local/cache_helper.dart';
import 'package:g_project/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:g_project/shared/styles/thems.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoard');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const AppLayout();
    } else {
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
              ..getCategoryProducts()
              ..getFavourites()
              ..getProfile(),
          ),
          BlocProvider(create: (context) => LoginCubit())
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  //darkTheme: darkTheme,
                  home: SplashScreen(start: start),
                ),
            listener: (context, state) {}));
  }
}
