import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_textstyles.dart';
import 'package:easy_mask/easy_mask.dart'; //mask for phone
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

Widget logInAddPhone(controllerPhone) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        child: Text(
          textAlign: TextAlign.center,
          globals.generalContentArray['logInPhoneText_1']
              .toString()
              .toUpperCase(),
          style: AppTextStyle.textSize36Light,
        ),
      ),
      SizedBox(
        width: 290,
        child: TextField(
          style: AppTextStyle.textSize16Dark,
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
