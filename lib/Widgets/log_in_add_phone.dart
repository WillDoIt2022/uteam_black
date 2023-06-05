import 'package:flutter/material.dart';
import '../styles/app_textstyles.dart';
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
          style: AppTextStyle.textSize32Light,
        ),
      ),


      SizedBox(
                  width: 300,
                  height: 39,

                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 250, 184, 108),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 1,
                      shadowColor: Color.fromARGB(255, 250, 250, 250),
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      globals.generalContentArray['logInPhoneText_2']
                          .toString()
                          .toUpperCase(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
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
                style: AppTextStyle.textSize12Dark,
                keyboardType: TextInputType.emailAddress,
                controller: controllerPhone,
                maxLines: 1,
                decoration: InputDecoration(
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
