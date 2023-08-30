import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

Widget logoImg(signUp) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          Container(
            height: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *(signUp?0.59:0.4),
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *(signUp?1:0.7),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/app_img/Main_pic.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      )
    ],
  );
}
