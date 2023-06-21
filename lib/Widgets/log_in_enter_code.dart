import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import '../styles/app_textstyles.dart';
import '../globals.dart' as globals;
import '../routes.dart';
import './auth.dart';
// ignore_for_file: prefer_const_constructors

Widget logInEnterCode(context, controllerCode, controllerPhone) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        //height: 140,
        child: Text(
          textAlign: TextAlign.center,
          globals.generalContentArray['logInCodeText_1']
              .toString()
              .toUpperCase(),
          style: AppTextStyle.textSize32Light,
        ),
      ),
      SizedBox(
                  height: 39,),
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
              controller: controllerCode,
              obscureText: true,
              obscuringCharacter: "*",
              enableSuggestions: false,
              autocorrect: false,
              onChanged: (text) async{
                if (controllerCode.text.length == 7) {
                  //Navigator.pushReplacementNamed(context, Routes.mainPage);
                  await Auth().registerWithEmailAndPassword(controllerPhone.text,controllerCode.text);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage,
                      (Route<dynamic> route) => false);
                }  else {
                  return;
                }
              },

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
                contentPadding: EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
