import 'package:chatinunii/authScreens/signup.dart';
import 'package:chatinunii/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../screens/chats/chats_screen.dart';
import '../screens/messages/components/fade_animation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

String? lang;

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
                                "Login",
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
                                  // boxShadow: const [
                                  //   BoxShadow(
                                  //       color: Colors.purpleAccent,
                                  //       blurRadius: 10,
                                  //       offset: Offset(1, 1)),
                                  // ],
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
                                        decoration: const InputDecoration(
                                          label: Text(" UserName"),
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
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          label: Text(" Password ..."),
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
                                  print(lang);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatsScreen()));
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
                                    "Didn't have a account? ",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signup()));
                                      },
                                      child: const Text(
                                        'Singup',
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
