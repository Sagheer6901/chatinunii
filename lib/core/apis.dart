// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:chatinunii/models/singupmodel.dart';
import 'package:chatinunii/models/statusmodel.dart';
import 'package:http/http.dart' as http;

class Apis {
  String baseurl = 'https://test-api.chatinuni.com';
  Future signUp(String username, String email, String password, String StatusId,
      String lang) async {
    String finalurl = '$baseurl/User/SignUp';
    var data = {
      'UserName': username,
      'Email': email,
      'Password': password,
      'StatusId': StatusId
    };
    var result = await http.post(Uri.parse(finalurl),
        body: jsonEncode(data),
        headers: {'lang': lang, 'Token': '0C4E22FF28214EBFB944C87F1A008ECB'});
    var msg = result.body;
    if (result.statusCode == 200) {
      return msg;
    }

    return msg;
  }

  Future getStatus(String lang) async {
    String finalurl = '$baseurl/User/GetStatusList';
    var result = await http.get(Uri.parse(finalurl), headers: {'lang': lang});
    if (result.statusCode == 200) {
      print(result.body);
      return statusModelFromJson(result.body);
    }
  }
}
