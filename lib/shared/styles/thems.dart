import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
  scaffoldBackgroundColor: HexColor('000000'),
  primarySwatch: Colors.teal,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      backgroundColor: HexColor('000000'),
      elevation: 30),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: HexColor('000000'),
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('000000'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
  /* floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ), */
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 30),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    
    backgroundColor: Colors.white,
    elevation: 0,
    shadowColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  ),
);