import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key, required this.start}) : super(key: key);
  final Widget start;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('assets/images/Dokantek22.jpg'),
        fit: BoxFit.cover,
        width: 330,
        height: 330,
      ),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: start,
      duration: 3000,
      backgroundColor: HexColor('ED1B36'),
    );
  }
}
