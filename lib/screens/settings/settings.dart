import 'package:chatinunii/authScreens/login.dart';
import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/constants.dart';
import 'package:chatinunii/screens/profile.dart';
import 'package:chatinunii/screens/settings/changepassword.dart';
import 'package:chatinunii/screens/settings/makemegolduser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(text: 'Settings'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              color: kPrimaryColor,
              width: double.infinity,
              child: Center(
                child: Container(
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
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangePassword()));
                },
                child: buildButton(Icons.change_circle, 'Change Password')),
            const Divider(
              color: kPrimaryColor,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MakeMeGoldUser()));
                },
                child: buildButton(Icons.verified_user, 'Make me gold user')),
            const Divider(
              color: kPrimaryColor,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      ModalRoute.withName('/login'));
                },
                child: buildButton(Icons.logout, 'Logout')),
            const Divider(
              color: kPrimaryColor,
            )
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar().buildbottonnavBar(3, context),
    );
  }

  Widget buildButton(var icon, String text) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Icon(
            icon,
            size: 30,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, color: kPrimaryColor),
          )
        ],
      ),
    );
  }
}
