import 'package:chatinunii/constants.dart';
import 'package:chatinunii/screens/chats/chatThroughStatus.dart';
import 'package:chatinunii/screens/chats/chats_screen.dart';
import 'package:chatinunii/screens/editprofile.dart';
import 'package:chatinunii/screens/profile.dart';
import 'package:chatinunii/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class BuildBottomNavBar {
  BottomNavigationBar buildbottonnavBar(int _selectIndex, context) {
    return BottomNavigationBar(
      fixedColor: kPrimaryColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectIndex,
      onTap: (value) {
        _selectIndex = value;
        btn(_selectIndex, context);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.messenger,
          ),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "People",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}

btn(i, context) {
  if (i == 0) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ChatsScreen()));
  } else if (i == 1) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatByStatus(
                  flag: true,
                )));
  } else if (i == 2) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Settings()));
  }
}
