import 'dart:convert';
import 'dart:io';

import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/components/toast.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/SiginInOrSignUp/signin_or_signup_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Chat.dart';
import '../messages/messages_screen.dart';
import 'components/chat_card.dart';

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
    Apis().GetMessageList().then((value) {
      if (value == 'Bad Request') {
        showToast('Error in getting messages');
      } else {
        setState(() {
          data = jsonDecode(value);
          print(jsonDecode(value));
        });
      }
    });
  }

  var data;
  @override
  Widget build(BuildContext context) {
    DateTime pre_backpress = DateTime.now();
    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            showToast('Press Back button again to Exit');
            return false;
          } else {
            exit(0);
          }
        },

        child: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: data['Response']['Records'].length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesScreen(
                            username: data['Response']['Records'][index]
                                ['ChatCreatedUserName'],
                            data: data['Response']['Records'][index],
                          ),
                        ),
                      );
                    },
                    chat: Chat(
                        name: data['Response']['Records'][index]
                            ['ChatCreatedUserName'],
                        lastMessage: data['Response']['Records'][index]
                            ['LastMessageDate'],
                        image: 'image',
                        time: data['Response']['Records'][index]
                            ['LastMessageDate'],
                        isActive: false),
                  );
                }),

        // Text(data['Response']['Records'][0]['ToUserName']);
        // }),
        // Column(
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //           itemCount: 0,
        //           itemBuilder: (context, index) => ChatCard(
        //                 press: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => MessagesScreen(
        //                         username: data['Response']['Records'][index]
        //                             ['ToUserName'],
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 chat: Chat(
        //                     name: data['Response']['Records'][0]
        //                         ['ChatCreatedUserName'],
        //                     lastMessage: data['Response']['Records'][0]
        //                         ['LastMessageDate'],
        //                     image: 'image',
        //                     time: data['Response']['Records'][0]
        //                         ['LastMessageDate'],
        //                     isActive: false),
        //               )),
        //     ),
        //   ],
        // ),
      ),
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
