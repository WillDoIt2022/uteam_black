import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

Widget logoImg(networkStatus) {
  return Column(
    mainAxisAlignment: networkStatus?MainAxisAlignment.center:MainAxisAlignment.start,
    children: [
      Stack(
        children: [
          Container(
            height: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *(networkStatus==true ?0.59:0.59),
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/app_img/Main_pic.PNG'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      )
    ],
  );
}
