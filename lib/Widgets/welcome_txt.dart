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
    ],
  );
}
