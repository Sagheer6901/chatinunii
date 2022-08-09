import 'dart:convert';
import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/chats/components/model.dart';
import 'package:chatinunii/screens/chats/components/statusmodel.dart';
import 'package:chatinunii/screens/messages/messages_screen.dart';
import 'package:chatinunii/screens/profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chatinunii/models/activeStatusUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../authScreens/login.dart';
import '../../authScreens/signup.dart';
import '../../constants.dart';
import '../SiginInOrSignUp/signin_or_signup_screen.dart';

class ChatByStatus extends StatefulWidget {
  bool flag;
  ChatByStatus({required this.flag});

  @override
  State<ChatByStatus> createState() => _ChatByStatusState();
}

class _ChatByStatusState extends State<ChatByStatus> {
  Locale? getlang;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        getlang = Localizations.localeOf(context);
      });
      Apis().getStatus(getlang!.toLanguageTag()).then((value) {
        setState(() {
          status = value;
        });
        // print(value.isSuccess);
        if (value.isSuccess == false) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Unable to get Status')));
        }
        // print(status!.response.statuses.length);
      }).whenComplete(() {
        range = status!.response.statuses.length;
        if (statuses.isEmpty) {
          for (var i = 0; i < range; i++) {
            statuses.add((status!.response.statuses[i].statusName).toString());
          }
          chatThroughStatus('null', getlang!.toLanguageTag().toString())
              .then((value) => print(value[0].userName));
        }
      });
    });
  }

  String? statusId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              'ChatInUni',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )),
      body: statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                statusList(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Divider(),
                Container(
                  height: widget.flag == false
                      ? MediaQuery.of(context).size.height * 0.775
                      : MediaQuery.of(context).size.height * 0.715,
                  width: double.infinity,
                  child: GetX<DateController>(
                      init: DateController(),
                      builder: (_) {
                        return SearchWidget(_.booking().date);
                      }),
                ),
              ],
            ),
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {});
        },
        child: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.shuffle,
                  size: 32,
                ),
                Text(
                  'shuffle',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.flag == false
          ? null
          : BuildBottomNavBar().buildbottonnavBar(1, context),
    );
  }

  List statuses = [];
  String? _mySelection;
  Widget statusList() {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        // color: kPrimaryColor,
        border: Border.all(color: kPrimaryColor),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
            DropdownButton<String>(
                hint: _mySelection == null
                    ? const Text('Select Status',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16))
                    : Text(_mySelection!,
                        style: const TextStyle(
                            color: kPrimaryColor, fontSize: 16)),
                style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                // dropdownColor: kPrimaryColor,
                items: statuses.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _mySelection = val;
                      print(_mySelection);
                    },
                  );
                  for (var i = 0; i < range; i++) {
                    if (status!.response.statuses[i].statusName ==
                        _mySelection) {
                      setState(() {
                        statusId = status!.response.statuses[i].statusId;
                        print(statusId);

                        Get.find<DateController>().updateBooking(statusId!);
                      });
                      break;
                    }
                  }
                  print(statusId);
                }),
          ],
        ),
      ),
    );
  }

  Future<List<Record>> chatThroughStatus(String statusId, String lang) async {
    String finalurl =
        'https://test-api.chatinuni.com/User/GetActiveUserList/$statusId';
    var result = await http
        .get(Uri.parse(finalurl), headers: {'lang': lang, 'Token': token!});
    var msg = await json.decode(result.body);
    if (result.statusCode == 200) {
      final parsed = json
          .decode(result.body)['Response']['Records']
          .cast<Map<String, dynamic>>();
      return parsed.map<Record>((json) => Record.fromJson(json)).toList();
    }

    return msg;
  }

  Widget SearchWidget(String statusId) {
    return FutureBuilder<List<Record>>(
        future:
            chatThroughStatus(statusId, getlang!.toLanguageTag().toString()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text('No user found'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile(
                                username: snapshot.data![index].userName,
                              )));
                    },
                    child: ListTile(
                      leading: SvgPicture.network(
                        snapshot.data![index].statusIcon,
                        height: 30,
                        width: 30,
                      ),
                      title: Text(snapshot.data![index].userName),
                      subtitle: Text(snapshot.data![index].statusText),
                      trailing: Icon(Icons.mail),
                    ),
                  );
                });
          } else {
            return SizedBox();
          }
        });
  }
}
