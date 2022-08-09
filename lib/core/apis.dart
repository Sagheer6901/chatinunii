// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:chatinunii/authScreens/login.dart';
import 'package:chatinunii/models/statusmodel.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../screens/SiginInOrSignUp/signin_or_signup_screen.dart';

class Apis {
  String baseurl = 'https://test-api.chatinuni.com';

  Future getToken() async {
    String finalurl = '$baseurl/User/GetPublicToken';
    var result = await http.post(Uri.parse(finalurl),
        headers: {'Content-Type': 'application/json'});
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg['IsSuccess'] == true) {
        return msg;
      } else {
        return 'error';
      }
    } else {
      return 'connectivity problem';
    }
  }

  Future signUp(String username, String email, String password, String StatusId,
      String lang) async {
    print(lang);
    String finalurl = '$baseurl/User/SignUp';
    var data = {
      'UserName': username,
      'Email': email,
      'Password': password,
      'StatusId': StatusId
    };
    var result = await http.post(Uri.parse(finalurl),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Token': token!
        });
    var msg = result.body;
    if (result.statusCode == 200) {
      print(msg);
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

  Future chatThroughStatus(String statusId, String lang) async {
    String finalurl = '$baseurl/User/GetActiveUserList/$statusId';
    var result = await http.post(Uri.parse(finalurl), headers: {
      'lang': lang,
      'Content-Type': 'application/json',
      'Token': token!
    });
    var msg = json.decode(result.body);
    if (result.statusCode == 200) {
      return msg;
    }

    return msg;
  }

  Future signIn(
      String username, String password, String lang, String Token) async {
    print(lang);
    print(Token);
    String finalurl = 'https://test-api.chatinuni.com/User/Login';
    var data = {"UserName": username, "Password": password};
    var result = await http.post(Uri.parse(finalurl),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Token': Token
        });
    var msg = result.body;
    if (result.statusCode == 200) {
      print(msg);
      return msg;
    }

    return msg;
  }

  Future getProfile() async {
    String finalurl = '$baseurl/User/GetProfile';
    var response = await http.get(Uri.parse(finalurl), headers: {
      'Content-Type': 'application/json',
      'lang': lang!,
      'Token': token!
    });
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future getUserProfile(String username) async {
    String finalurl = '$baseurl/User/GetUserProfileDetail/$username';
    var response = await http.get(Uri.parse(finalurl), headers: {
      'Content-Type': 'application/json',
      'lang': lang!,
      'Token': token!
    });
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future forgetPassword(String username) async {
    String finalurl = '$baseurl/User/ForgotPassword';
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode({'UserName': username}));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future updateProfile(
      String username, String password, String email, String statusId) async {
    String finalurl = '$baseurl/User/UpdateProfile';
    var data = {
      'UserName': username,
      'Password': password,
      'Email': email,
      'StatusId': statusId,
    };
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future changePassword(String oldPassword, String newpassword) async {
    String finalurl = '$baseurl/User/ChangePassword';
    var data = {'OldPassword': oldPassword, 'Password': newpassword};
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future uploadPhoto(String fileName, var img) async {
    String finalurl = '$baseurl/User/UploadProfilePhoto';
    var data = {"ImageBase64": img, "FileName": '$fileName.jpg'};
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future deletePhoto(String fileName) async {
    String finalurl = '$baseurl/User/DeleteProfilePhoto/$fileName';
    var response = await http.post(Uri.parse(finalurl), headers: {
      'Content-Type': 'application/json',
      'lang': lang!,
      'Token': token!
    });
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future complaintUser(
      {required String chatId,
      required String toUsername,
      required String reason}) async {
    String finalurl = '$baseurl/User/ComplaintUser/$chatId';
    var data = {'ToUserName': toUsername, 'ReasonText': reason};
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future sendGoldUserRequest({required String phoneNumber}) async {
    String finalurl = '$baseurl/User/SendGoldRequest';
    var data = {'PhoneNumber': phoneNumber};
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future blockByUser(
      {required String blockedUserNme, required String chatId}) async {
    String finalurl = '$baseurl/User/BlockUserByUser';
    var data = {'BlockedUserName': blockedUserNme, 'ChatId': chatId};
    var response = await http.post(Uri.parse(finalurl),
        headers: {
          'Content-Type': 'application/json',
          'lang': lang!,
          'Token': token!
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future setProfileImage(String field) async {
    String finalUrl = '$baseurl/User/SetMainProfilePhoto/$field';
    var response = await http.post(
      Uri.parse(finalUrl),
      headers: {
        'Content-Type': 'application/json',
        'lang': lang!,
        'Token': token!
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future GetMessageList() async {
    String finalUrl = '$baseurl/User/GetMessageList';
    var response = await http.get(
      Uri.parse(finalUrl),
      headers: {
        'Content-Type': 'application/json',
        'lang': lang!,
        'Token': token!
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }
}
