import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../authScreens/login.dart';
import '../../constants.dart';
import '../SiginInOrSignUp/signin_or_signup_screen.dart';
import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  final username;
  var data;
  MessagesScreen({Key? key, required this.username, required this.data})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  IO.Socket socket = IO.io('https://test-api.chatinuni.com', <String, dynamic>{
    "transports": ["websocket"]
  });
  var msgList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(socket.connected);
    socket.on('CreateChat', (data) {
      setState(() {
        msgList = data;
      });
      print(msgList);
      print('done');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(
        username: widget.username,
        data: widget.data,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/user_2.png",
            ),
          ),
          const SizedBox(
            width: kDefaultPadding * 0.75,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
