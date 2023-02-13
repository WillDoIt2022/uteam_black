import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

Widget logoImg(timer) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          Container(
            height: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *(timer?0.9:0.5),
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/Logo_UTEAM.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      )
    ],
  );
}
