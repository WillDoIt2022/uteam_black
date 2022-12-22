import 'package:flutter/material.dart';
import 'dart:async';
import '../Widgets/add_phone.dart';
// ignore_for_file: prefer_const_constructors

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _LaunchApp();
  }
}

class _LaunchApp extends State<WelcomePage> {
  dynamic _timer;
  @override
  void initState() {
    super.initState();
    _timer = true;
    //Go to Log in password page in a 5 seconds
    Timer(Duration(seconds: 3), () {
      setState(
        () {
          _timer = false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
      title: 'UTEAM',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 58, 63),
        body:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        width: 390,
                        height: 400,
                      ),
                      Positioned(
                        right: 18,
                        top: 0,
                        child: Container(
                          width: 390,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('img/Logo_guy.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 45,
                        child: Container(
                          width: 139,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('img/Logo_house.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 170,
                        child: Container(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('img/Logo_dashbord.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 55,
                        top: 190,
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('img/Logo_box.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _timer?
                  Column(
                    children: <Widget>[
                  Text(
                    "WELCOME TO",
                    style: TextStyle(
                      fontSize: 36,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "UTEAM",
                    style: TextStyle(
                      fontSize: 36,
                      color: Color.fromARGB(255, 124, 160, 209),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                ),],): LoginWidget(),
                ],
              )
            
      ),
    );
  }
}
