import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(FontAwesome5.bell,size: 140,color: Colors.grey[300],),
            const SizedBox(height: 10,),
            Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[400]
              ),
            )
          ],
        ),
      ),
    );
  }
}
