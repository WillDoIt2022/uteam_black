import 'package:flutter/material.dart';
import 'dart:async'; //For timer working
import 'dart:math'; //For random number code generator
import 'package:another_flushbar/flushbar.dart';
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
  final controllerPhone = TextEditingController(text: "+33");
  dynamic controllerCode = TextEditingController(text: "");
  dynamic timer;
  dynamic next;
  dynamic randomCode;

  @override
  void initState() {
    super.initState();
    next = true;
    timer = true;

    //Go to Log in password page in a 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(
        () {
          timer = false;
        },
      );
    });
  }

  randomCodeGenerator() {
    Random random = Random();
    randomCode = random.nextInt(8999) + 1000; // from 1000 upto 9999 included
  }

  @override
  Widget build(BuildContext context) {
    //title: _timer ? 'UTEAM WELCOME' : "Log in password",
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 58, 63),
        body: Column(
          mainAxisAlignment:
              timer ? MainAxisAlignment.center : MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            !timer
                ? next
                    ? Align(
                        alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 30),
                                elevation: 0.0,
                                backgroundColor: Colors.black.withOpacity(0.05),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    if (controllerPhone.text.length < 17) {
                                      Flushbar(
                                        title: 'Warning',
                                        titleColor: Colors.yellow,
                                        titleSize: 18,
                                        message: 'Phone number is invalid',
                                        messageSize: 14,
                                        duration: Duration(seconds: 4),
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                      return;
                                    } else {
                                      next = !next;
                                      controllerCode =
                                          TextEditingController(text: "");
                                      randomCodeGenerator();
                                    }
                                  },
                                );
                              },
                              child: Text('next>'.toUpperCase()),
                            ),
                          ),
                        
                      )
                    : Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(top: 30),
                              elevation: 0.0,
                              backgroundColor: Colors.black.withOpacity(0.05),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  if (!next) {
                                    next = !next;
                                  }
                                },
                              );
                            },
                            child: Text('<back'.toUpperCase()),
                          ),
                        ),
                         )
                : Container(),
                Stack(
              children: [
                SizedBox(
                  width: timer ? 390 : 252,
                  height: timer ? 390 : 257,
                  
                ),
                Positioned(
                  right: timer ? 18 : 15,
                  top: 0,
                  child: Container(
                    width: timer ? 390 : 252,
                    height: timer ? 390 : 257,
                    decoration: BoxDecoration(
                      //color:Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                        image: AssetImage('img/Logo_guy.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: timer ? 30 : 20,
                  top: timer ? 45 : 25,
                  child: Container(
                    width: timer ? 139 : 89,
                    height: timer ? 140 : 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('img/Logo_house.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: timer ? 30 : 15,
                  top: timer ? 170 : 120,
                  child: Container(
                    width: timer ? 37 : 24,
                    height: timer ? 37 : 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('img/Logo_dashbord.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: timer ? 55 : 40,
                  top: timer ? 190 : 130,
                  child: Container(
                    width: timer ? 85 : 55,
                    height: timer ? 85 : 55,
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
            timer
                ? Column(
                    children: [
                      Text(
                        "welcome to".toUpperCase(),
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
                      ),
                    ],
                  )
                : loginWidget(
                    context, next, controllerPhone, controllerCode, randomCode),
          ],
        ));
  }
}
