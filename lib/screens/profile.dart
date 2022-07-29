import 'dart:convert';
import 'package:chatinunii/components/toast.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/editprofile.dart';
import 'package:chatinunii/screens/uploadphoto.dart';
import 'package:flutter/material.dart';
import '../components/bottomnavbar.dart';
import '../constants.dart';
import 'messages/components/fade_animation.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

var data;

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Apis().getProfile().then((value) {
      print(value);
      if (value == 'Bad Response') {
        showToast('Error! Can\'t Get User profile');
      } else {
        setState(() {
          data = jsonDecode(value);
        });
        for (var i = 0;
            i <
                jsonDecode(value)["Response"]['Records'][0]['ProfilePhotos']
                    .length;
            i++) {
          if (jsonDecode(value)["Response"]['Records'][0]['ProfilePhotos'][i]
                  ['MainPhoto'] ==
              1) {
            setState(() {
              mainPhoto = jsonDecode(value)["Response"]['Records'][0]
                  ['ProfilePhotos'][i]['FileURL'];
            });
            break;
          }
        }
      }
    });
  }

  String mainPhoto = 'abcd';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(text: "Profile"),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : FadeAnimation(
              0.5,
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(mainPhoto),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data["Response"]['Records'][0]['UserName'],
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Text(data["Response"]['Records'][0]['Email'],
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile()));
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Ink(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            gradient: const LinearGradient(
                                colors: [Colors.white, Colors.white]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: 200,
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.566,
                      child: data["Response"]['Records'][0]['ProfilePhotos'] ==
                              null
                          ? Center(
                              child: Text('No Photos Found'),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: data["Response"]['Records'][0]
                                      ['ProfilePhotos']
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: (context),
                                          builder: (context) => showDetails(
                                              data["Response"]['Records'][0]
                                                      ['ProfilePhotos'][index]
                                                  ['FileURL'],
                                              data["Response"]['Records'][0]
                                                      ['ProfilePhotos'][index]
                                                  ['FileId']));
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  data["Response"]['Records'][0]
                                                          ['ProfilePhotos']
                                                      [index]['FileURL']),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool flag = false;
          if (data["Response"]['Records'][0]['ProfilePhotos'] == null) {
            flag = true;
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UploadPhoto(
                    flag: flag,
                  )));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.add_a_photo),
            FittedBox(
                child: Text(
              'Upload\nPicture',
              style: TextStyle(fontSize: 9.5),
            ))
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar().buildbottonnavBar(2, context),
    );
  }

  String? localmage;

  Widget showDetails(String img, String field) {
    return AlertDialog(
        title: Image(image: NetworkImage(img)),
        content: FittedBox(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Apis().deletePhoto(field).then((value) {
                    if (value == 'Bad Response') {
                      showToast('Error! can\'t delete photo at the moment');
                    } else {
                      showToast('Photo has been deleted');
                      Navigator.pop(context);
                      setState(() {});
                    }
                  });
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: kPrimaryColor,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(color: kPrimaryColor),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  Apis().setProfileImage(field).then((value) {
                    if (value == 'Bad Response') {
                      showToast('Error! can\'t set profile photo');
                    } else {
                      showToast('Profile photo is set');
                      Navigator.pop(context);
                      setState(() {});
                    }
                  });
                },
                child: Row(
                  children: const [
                    Icon(Icons.person, color: kPrimaryColor),
                    Text('Set as main photo',
                        style: TextStyle(color: kPrimaryColor))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

AppBar buildAppBar({required String text}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kPrimaryColor,
    title: Text(
      text,
    ),
  );
}
