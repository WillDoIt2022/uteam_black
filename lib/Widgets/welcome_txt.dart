import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

Widget welcomeTxt(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "welcome to".toUpperCase(),
                        style: TextStyle(
                          fontSize: 36,
                          color: Color.fromARGB(255, 124, 160, 209),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "UTEAM".toUpperCase(),
                        style: TextStyle(
                          fontSize: 36,
                          color: Color.fromARGB(255, 15, 77, 154),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );}