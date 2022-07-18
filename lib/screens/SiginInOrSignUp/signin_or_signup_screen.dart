import 'package:chatinunii/authScreens/login.dart';
import 'package:chatinunii/authScreens/signup.dart';
import 'package:flutter/material.dart';

import '../../components/primary_button.dart';
import '../../constants.dart';
import '../chats/chats_screen.dart';

class SignInOrSignUpScreen extends StatelessWidget {
  const SignInOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              // Image.asset(
              //   MediaQuery.of(context).platformBrightness == Brightness.light
              //       ? "assets/images/Logo_light.png"
              //       : "assets/images/Logo_dark.png",
              //   height: 146,
              // ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 3),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'ChatInUni',
                  style: TextStyle(
                      fontSize: 40,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                  text: "Sign In",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  }),
              const SizedBox(
                height: kDefaultPadding * 1.5,
              ),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  );
                },
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
