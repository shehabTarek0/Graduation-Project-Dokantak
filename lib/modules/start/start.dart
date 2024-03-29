import 'package:flutter/material.dart';
import 'package:g_project/modules/marchant/Login_mer/login_screen.dart';
import 'package:g_project/modules/user/Login/login_screen.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/styles/colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Image(
                    image: AssetImage('assets/images/start.png'),
                    width: 80,
                    height: 50,
                  ),
                  Container(
                    color: Colors.black,
                    width: 2,
                    height: 60,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'DOKANTAK',
                    style: TextStyle(
                      fontSize: 55,
                      letterSpacing: 0.5,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Login To Your Account',
                style: TextStyle(fontSize: 25, color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 50,
              ),
              defaultButton(
                  function: () => navigateTo(context, LoginScreen()),
                  text: 'Login as an User',
                  background: mainColor,
                  width: 370,
                  isUpperCase: false,
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
              const SizedBox(
                height: 15,
              ),
              defaultButton(
                  function: () => navigateTo(context, LoginUMarScreen()),
                  text: 'Login as a Merchant',
                  background: mainColor,
                  width: 370,
                  isUpperCase: false,
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
