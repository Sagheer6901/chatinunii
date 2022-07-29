import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/screens/SiginInOrSignUp/signin_or_signup_screen.dart';
import 'package:chatinunii/screens/editprofile.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../chats/components/body.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: BuildBottomNavBar().buildbottonnavBar(0, context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: const Text(
        "Chats",
      ),
    );
  }
}
