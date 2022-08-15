import 'dart:convert';
import 'dart:io';

import 'package:chatinunii/authScreens/forgetPassword.dart';
import 'package:chatinunii/authScreens/signup.dart';
import 'package:chatinunii/constants.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/SiginInOrSignUp/signin_or_signup_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../components/toast.dart';
import '../screens/chats/chats_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

String? lang;
Apis apis = Apis();
IO.Socket socket = IO.io('https://test-api.chatinuni.com', <String, dynamic>{
  "transports": ["websocket"],
  "autoConnect": false
});

class _LoginState extends State<Login> {
  @override
  void didChangeDependencies() {
    Locale myLocale = Localizations.localeOf(context);
    setState(() {
      lang = myLocale.toLanguageTag();
    });
    print('my locale ${myLocale.toLanguageTag()}');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernamecontroller.clear();
    passwordcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              // Colors.purple,
              kPrimaryColor,
              kContentColorLightTheme,
            ])),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'ChatInUni',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  margin: const EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          // color: Colors.red,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 22, bottom: 20),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                letterSpacing: 2,
                                fontFamily: "Lobster"),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: kPrimaryColor, width: 1),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.email_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: usernamecontroller,
                                      decoration: const InputDecoration(
                                        label: Text(" UserName"),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          width: double.infinity,
                          height: 70,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 1),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.password_outlined),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: passwordcontroller,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      label: Text(" Password ..."),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Forget Password? ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPassword()));
                                  },
                                  child: const Text(
                                    'Click here',
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 15),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              onPrimary: kPrimaryColor,
                              elevation: 5,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [kPrimaryColor, kPrimaryColor]),
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () {
                                print(token);
                                signIn(usernamecontroller.text,
                                        passwordcontroller.text)
                                    .then((value) {
                                  print(value);
                                  if (value == 'Bad Request') {
                                    showToast("Can not signin");
                                  } else {
                                    socket.connect();
                                    print('before update ${socket.id}');
                                    socket.onConnect((data) async {
                                      print('connected');
                                      print(socket.connected);
                                    });
                                    socket.on(
                                        'connection',
                                        (data) =>
                                            {print('socket id: ${socket.id}')});

                                    print('done');
                                    // print('updated socketid: ${socket.id}');
                                    token =
                                        jsonDecode(value)['Response']['Token'];
                                    // print(
                                    //     jsonDecode(value)['Response']['Token']);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatsScreen()));
                                    showToast(
                                        'you logged in as ${usernamecontroller.text}');
                                  }
                                });
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 70,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Didn't have a account? ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Signup()));
                                    },
                                    child: const Text(
                                      'Singup',
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 15),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future signIn(String username, String password) async {
    String finalurl = 'https://test-api.chatinuni.com/User/Login';
    var data = {"UserName": username, "Password": password};
    var result = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!,
        },
        body: jsonEncode(data));
    print(result.body);
    if (result.statusCode == 200) {
      print(result.body);
      return result.body;
    }

    return result.body;
  }
}
