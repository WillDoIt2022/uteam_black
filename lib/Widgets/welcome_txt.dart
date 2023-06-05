import 'package:flutter/material.dart';
import '../styles/app_textstyles.dart';
// ignore_for_file: prefer_const_constructors

Widget welcomeTxt() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "welcome to".toUpperCase(),
        style: AppTextStyle.textSize36Light,
      ),
      Text(
        "UTEAM".toUpperCase(),
        style: AppTextStyle.textSize36Dark,
      ),
      Container(
            height: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *0.2,
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/app_img/UTEAM_logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
    ],
  );
}
