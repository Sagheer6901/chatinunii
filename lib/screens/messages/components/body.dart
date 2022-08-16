import 'dart:convert';

import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/profile.dart';
import 'package:flutter/material.dart';

import '../../../authScreens/login.dart';
import '../../../constants.dart';
import '../../../models/ChatMessage.dart';
import 'chatInput_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  // final messagelist;
  final username;
  var data;
  Body({Key? key, required this.username, required this.data})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  var msgList;
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get Message
    print('chatId ${widget.data['ChatId']}');
    print('messages:${widget.data['Messages'][0]['Message']}');
    print('body: ${socket.connected}');
    socket.on('Message', (data) => {print(data)});
    print(msgList);
  }

  // final ScrollController _controller = ScrollController();

// This is what you're looking for!
  // void _scrollDown() {
  //   _controller.jumpTo(_controller.position.maxScrollExtent);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: SingleChildScrollView(
                reverse: true,
                child: StreamBuilder(
                  stream: Apis().getAllMessages(),
                  builder: (context, snapshot)
                 {
                  return ListView.builder(
                    // reverse: true,.
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!,
                    itemBuilder: (context, index) {
                      return Message(
                        message: ChatMessage(
                            text: widget.data['Messages'][index]['Message'],
                            messageType: ChatMessageType.text,
                            messageStatus: MessageStatus.viewed,
                            isSender: widget.data['Messages'][index]
                                        ['ToUserName'] ==
                                    widget.username
                                ? true
                                : false),
                        image: widget.data['ProfilePhotos'][0]['FileURL'],
                      );
                    })
                })
                ),
          ),
        ),
        ChatInputField(
          username: widget.username,
          chatId: widget.data['ChatId'],
        ),
      ],
    );
  }
}
