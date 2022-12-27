import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_mask/easy_mask.dart';
import 'dart:math';
// ignore_for_file: prefer_const_constructors

Widget loginWidget(_next) {
  Random random = Random();
  int randomNumber =
      random.nextInt(9999) + 1000; // from 1000 upto 9999 included
  print(randomNumber);
  print(_next);

  return 
 
  _next
      ? Column(children: <Widget>[  
          SizedBox(
            height:125,
            child: Text(
            textAlign: TextAlign.center,
            "enter your\nphone number".toUpperCase(),
            style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),),
          SizedBox(
            width: 290,
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: "+33"),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputMask(mask: '\\+99 999 999 99 99', reverse: false)
              ],
              maxLines: 1,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                border: InputBorder.none,
                labelText: '',
                hintText: '',
                contentPadding: EdgeInsets.only(left: 24.0),
              ),
            ),
          ),
        ])
      : Column(
          children: <Widget>[
            SizedBox(
            height:125,
            child:Text(
              textAlign: TextAlign.center,
              "enter code we\nsended on your\nphone number".toUpperCase(),
              style: TextStyle(
                fontSize: 36,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),),
            SizedBox(
              width: 290,
              child: TextField(
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: ""),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  border: InputBorder.none,
                  labelText: '',
                  hintText: '',
                  contentPadding: EdgeInsets.only(left: 24.0),
                ),
              ),
            ),
          ],
        );
}
