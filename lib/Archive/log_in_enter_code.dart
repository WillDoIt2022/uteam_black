import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import '../globals.dart' as globals;
import '../routes.dart';
// ignore_for_file: prefer_const_constructors

Widget logInEnterCode(context, controllerCode, randomCode) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 140,
        child: Text(
          textAlign: TextAlign.center,
          globals.generalContentArray['logInCodeText_1']
              .toString()
              .toUpperCase(),
          style: TextStyle(
            fontSize: 36,
            color: Color.fromARGB(255, 124, 160, 209),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.1,
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/app_img/UTEAM_logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.6,
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 15, 77, 154),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              controller: controllerCode,
              onChanged: (text) {
                if (int.parse(controllerCode.text) == randomCode) {
                  //Navigator.pushReplacementNamed(context, Routes.mainPage);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage,
                      (Route<dynamic> route) => false);
                } else if (controllerCode.text.length == 4 &&
                    int.parse(controllerCode.text) != randomCode) {
                  Flushbar(
                    title: 'Warning',
                    titleColor: Colors.yellow,
                    titleSize: 18,
                    message: 'Check if the specified code is correct',
                    messageSize: 14,
                    duration: Duration(seconds: 3),
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context);
                } else {
                  return;
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              maxLines: 1,
              decoration: InputDecoration(
                //isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 15, 77, 154)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 15, 77, 154)),
                ),
                border: InputBorder.none,
                labelText: '',
                hintText: '',
                contentPadding: EdgeInsets.only(left: 24.0),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
