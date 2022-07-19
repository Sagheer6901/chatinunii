import 'package:flutter/material.dart';

import '../../../components/filled_outline_button.dart';
import '../../../constants.dart';
import '../../../models/Chat.dart';
import '../../messages/messages_screen.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesScreen(),
                        ),
                      );
                    },
                    chat: chatsData[index],
                  )),
        ),
      ],
    );
  }
}
