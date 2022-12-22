import 'package:flutter/material.dart';
import 'Pages/welcome_page.dart';
// ignore_for_file: prefer_const_constructors
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _Welcome();
  }
}
class _Welcome extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return WelcomePage(); 
  }
}