import 'dart:async';

import 'package:chatinunii/constants.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/models/statusmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/chats/chats_screen.dart';
import '../screens/messages/components/fade_animation.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

Apis apis = Apis();

TextEditingController usernamecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController confirmpasswordcontroller = TextEditingController();
StatusModel? status;

class _SignupState extends State<Signup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apis.getStatus().then((value) {
      setState(() {
        status = value;
      });
      print(value.isSuccess);
      if (value.isSuccess == false) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to get Status')));
      }
    });
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
                child: const FadeAnimation(
                  2,
                  Text(
                    'ChatInUni',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                )),
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
                            child: const FadeAnimation(
                              2,
                              Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black87,
                                    letterSpacing: 2,
                                    fontFamily: "Lobster"),
                              ),
                            )),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
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
                                          label: Text(" Username"),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  // boxShadow: const [
                                  //   BoxShadow(
                                  //       color: Colors.purpleAccent,
                                  //       blurRadius: 10,
                                  //       offset: Offset(1, 1)),
                                  // ],
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.password_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          label: Text("Email"),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  // boxShadow: const [
                                  //   BoxShadow(
                                  //       color: Colors.purpleAccent,
                                  //       blurRadius: 10,
                                  //       offset: Offset(1, 1)),
                                  // ],
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
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
                                          label: Text(" Password"),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  // boxShadow: const [
                                  //   BoxShadow(
                                  //       color: Colors.purpleAccent,
                                  //       blurRadius: 10,
                                  //       offset: Offset(1, 1)),
                                  // ],
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.password_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: confirmpasswordcontroller,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          label: Text("Confirm Password"),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const ChatsScreen()));
                              print(status!.response.statuses[0].statusName);
                            },
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
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: kPrimaryColor, fontSize: 15),
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
