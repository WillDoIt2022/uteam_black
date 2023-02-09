import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

Widget logoImg(timer) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          SizedBox(
            width: timer ? 390 : 252,
            height: timer ? 370 : 235,
          ),
          Positioned(
            right: timer ? 18 : 15,
            child: Container(
              height: timer ? 390 : 257,
              width: timer ? 390 : 252,
              decoration: BoxDecoration(
                //color: Color.fromARGB(255, 255, 255, 255),
                image: DecorationImage(
                  image: AssetImage('assets/img/Logo_guy.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            right: timer ? 30 : 20,
            top: timer ? 45 : 25,
            child: Container(
              width: timer ? 139 : 89,
              height: timer ? 140 : 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Logo_house.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            right: timer ? 30 : 15,
            top: timer ? 170 : 120,
            child: Container(
              width: timer ? 37 : 24,
              height: timer ? 37 : 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Logo_dashbord.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            right: timer ? 55 : 40,
            top: timer ? 190 : 130,
            child: Container(
              width: timer ? 85 : 55,
              height: timer ? 85 : 55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Logo_box.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
