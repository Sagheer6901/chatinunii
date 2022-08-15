import 'package:chatinunii/screens/SiginInOrSignUp/signin_or_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../authScreens/login.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  final username;
  var chatId;
  ChatInputField({Key? key, required this.username, required this.chatId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController msg = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: const Color(0xFF087949).withOpacity(0.08),
            ),
          ]),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.75),
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(
                      width: kDefaultPadding / 4,
                    ),
                    Expanded(
                      child: TextField(
                        controller: msg,
                        decoration: const InputDecoration(
                          hintText: "Type Message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        var p = {
                          'ChatId':
                              chatId, // which is support from GetMessageList end point,
                          'Message': msg.text, // message which user enters,
                          'ToUserName': username, // selected user in chat,
                          'Lang': lang!, //-phone language
                          'Token':
                              token!, //-- which is supported endpoint GetPublicToken, Login, SignUp,
                          'IsFromLoggedUser': true //-- everytime true,
                        };

                        socket.emit('Message', p);
                        socket.on('Message', (data) => print(data));
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color
                            ?.withOpacity(0.64),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
