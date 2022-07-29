import 'package:chatinunii/authScreens/login.dart';
import 'package:chatinunii/screens/chats/chatThroughStatus.dart';
import 'package:chatinunii/screens/editprofile.dart';
import 'package:chatinunii/screens/profile.dart';

import '/screens/splashscreen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: SplashScreen()),
      // EditProfile()),
    );
  }
}
