import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:easy_mask/easy_mask.dart'; //mask for phone
// ignore_for_file: prefer_const_constructors

Widget loginWidget(context, next, controllerPhone, controllerCode, randomCode) {
  print(randomCode);
  return next
      ? Column(children: <Widget>[
          SizedBox(
            height: 125,
            child: Text(
              textAlign: TextAlign.center,
              "enter your\nphone number".toUpperCase(),
              style: TextStyle(
                fontSize: 36,
                color: Color.fromARGB(255, 255, 255, 255),
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
                color: Color.fromARGB(255, 255, 255, 255),
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
              height: 125,
              child: Text(
                textAlign: TextAlign.center,
                "enter code we\nsended on your\nphone number".toUpperCase(),
                style: TextStyle(
                  fontSize: 36,
                  color: Color.fromARGB(255, 255, 255, 255),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
                keyboardType: TextInputType.number,
                controller: controllerCode,
                onChanged: (text) {
                  if (int.parse(controllerCode.text) == randomCode) {
                    Navigator.pushNamed(context, '/main_page');
                  } else if (controllerCode.text.length == 4 &&
                      int.parse(controllerCode.text) != randomCode) {
                    Flushbar(
                      title: 'Warning',
                      titleColor: Colors.yellow,
                      titleSize: 18,
                      message: 'Check if the specified code is correct',
                      messageSize: 14,
                      duration: Duration(seconds: 4),
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
