import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_mask/easy_mask.dart'; //mask for phone
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

Widget logInAddPhone(controllerPhone) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        //height: 150,
        child: Text(
          textAlign: TextAlign.center,
          globals.generalContentArray['logInPhoneText_1'].toString().toUpperCase(),
          style: TextStyle(
            fontSize: 36,
            color: Color.fromARGB(255, 124, 160, 209),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(
        width: 290,
        child: TextField(
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 15, 77, 154),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
          keyboardType: TextInputType.number,
          controller: controllerPhone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TextInputMask(mask: '\\+99 999 999 99 99', reverse: false)
          ],
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 15, 77, 154)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 15, 77, 154)),
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
