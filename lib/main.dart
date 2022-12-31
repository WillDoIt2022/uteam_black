import 'package:flutter/material.dart';
import 'Pages/welcome_page.dart';
import 'Pages/main_page.dart';
// ignore_for_file: prefer_const_constructors
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _Launch();
  }
}

class _Launch extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
      initialRoute: '/',
      title:"UTEAM",
      routes:{
        '/':(BuildContext context)=>WelcomePage(),
        '/main_page':(BuildContext context)=>MainPage(),
      },
    );
  }
  }
