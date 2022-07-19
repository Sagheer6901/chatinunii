import 'package:chatinunii/screens/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/bottomnavbar.dart';
import '../constants.dart';
import 'messages/components/fade_animation.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

List<String> images = [
  'https://images.unsplash.com/photo-1658224086798-85d89fe35252?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=392&q=80',
  'https://images.unsplash.com/photo-1658144492483-912cc8f969b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
  'https://images.unsplash.com/photo-1658158672450-6fc5fd6957db?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  'https://images.unsplash.com/photo-1658148719317-1cce3e269d21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80'
];

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FadeAnimation(
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
                      children: const [
                        CircleAvatar(
                          radius: 70,
                          child: Image(
                              image: AssetImage('assets/images/user_2.png')),
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
                        'username',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text('email@gmail.com',
                          style: TextStyle(color: kPrimaryColor, fontSize: 16)),
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
                      builder: (context) => const EditProfile()));
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: (context),
                              builder: (context) => showDetails(images[index]));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(images[index]),
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
      bottomNavigationBar: BuildBottomNavBar().buildbottonnavBar(2, context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: const Text(
        "Profile",
      ),
    );
  }

  Widget showDetails(String img) {
    return AlertDialog(
        title: Image(image: NetworkImage(img)),
        content: const Text(
          'userName',
          style: TextStyle(color: kPrimaryColor),
          textAlign: TextAlign.center,
        ));
  }
}
