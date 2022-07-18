// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, unused_label, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:typed_data';
import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String localmage = '';
  TextEditingController usernamee = TextEditingController();
  TextEditingController contactt = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController image = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: Stack(
                children: [
                  // CircleAvatar(
                  //             radius: 50,
                  //             backgroundImage:
                  //                 MemoryImage(base64Decode(data[image])))
                  //         :
                  const CircleAvatar(
                    radius: 50,
                  ),
                  InkWell(
                    onTap: () {
                      chooseImage();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: kPrimaryColor,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  buildTextField(
                      "Username",
                      usernamee,
                      Icon(
                        Icons.abc,
                        color: kPrimaryColor,
                        size: 35,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  buildTextField(
                      "Status",
                      addresss,
                      Icon(
                        Icons.tips_and_updates_sharp,
                        color: kPrimaryColor,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {},
                    color: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar().buildbottonnavBar(2, context),
    );
  }

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != null)
      image:
      localmage;
  }

  Future<String> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imagePicker =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (_imagePicker != null) {
      Uint8List bytes = await _imagePicker.readAsBytes();

      String encode = base64Encode(bytes);

      return encode;
    } else {
      if (kDebugMode) {
        print('Pick Image First');
      }
      return 'Error';
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: const Text(
        "Edit Profile",
      ),
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController ctrl, Icon icon) {
    return Container(
        width: double.infinity,
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: ctrl,
                  maxLines: 1,
                  decoration: InputDecoration(
                    label: Text(labelText),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
