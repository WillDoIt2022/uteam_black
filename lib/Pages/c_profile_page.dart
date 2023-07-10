import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import '../routes.dart';
import"../Widgets/footer_menu.dart";
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return ProfileSettings();
  }
}

class ProfileSettings extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 6,
            child: Container(),
          ),
          Expanded(
            flex: 6,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: FooterMenu(),
          ),
        ],
      ),
    );
  }
}
