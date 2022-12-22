import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: prefer_const_constructors

Widget LoginWidget() {
  return Column(children: <Widget>[
    Text(
      textAlign: TextAlign.center,
      "ENTER YOUR\nPHONE NUMBER",
      style: TextStyle(
        fontSize: 36,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
    ),
    SizedBox(
      width: 290,
    child:TextField(
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                   ),  
          border: InputBorder.none, labelText: '', hintText: ''),
    ),),
  ]);
}
