import 'package:chatinunii/authScreens/login.dart';
import 'package:chatinunii/test.dart';

import '/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  // IO.Socket socket = IO.io('https://test-api.chatinuni.com', <String, dynamic>{
  //   'transports': ['websocket']
  // });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // socket.onConnect((data) {
    //   print('connected');
    //   print(socket.connected);
    // });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      home:
          // Test()
          SafeArea(child: SplashScreen()
              // Test()
              ),
      // EditProfile()),
    );
  }
}
