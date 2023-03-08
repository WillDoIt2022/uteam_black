import 'package:flutter/material.dart';
import 'dart:async'; //For timer working
import 'dart:math'; //For random number code generator
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:data_connection_checker/data_connection_checker.dart'; //Internet connection checker
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/network_checker.dart';
import '../Widgets/logo_img.dart';
import '../Widgets/log_in.dart';
import '../Widgets/welcome_txt.dart';
import '../globals.dart' as globals;

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
  //bool isInternet = false;

  @override
  void initState() {
    super.initState();
    print(BlocProvider.of<NetworkChecker>(context).state);
    BlocProvider.of<NetworkChecker>(context)
        .add(CheckInternetConnectionEvent());
    print(BlocProvider.of<NetworkChecker>(context).state);

//Internet Connection Checker
    //WidgetsBinding.instance
    //.addPostFrameCallback((_) => internetConnectionChecker());

    next = true;
    timer = true;
    //Go to Log in password page in a 5 seconds
    timerStart();
  }

  timerStart() {
    Timer(Duration(seconds: 5), () {
      if (BlocProvider.of<NetworkChecker>(context).state == false) {
        return;
      } else {
        setState(
          () {
            timer = false;
          },
        );
      }
    });
  }

  randomCodeGenerator() {
    Random random = Random();
    randomCode = random.nextInt(8999) + 1000; // from 1000 upto 9999 included

    Flushbar(
      title: '$randomCode',
      titleColor: Colors.green,
      titleSize: 18,
      message: 'Code to access',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Expanded(
              flex: 2,
              child: !timer
                  ? next
                      ? Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 25),
                                elevation: 0.0,
                                backgroundColor: Colors.white.withOpacity(0.05),
                              ),
                              onPressed: () async {
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
                                      print(controllerPhone.text);
                                      globals.phoneNumber =
                                          controllerPhone.text;

                                      controllerCode =
                                          TextEditingController(text: "");

                                      randomCodeGenerator();
                                    }
                                  },
                                );
                              },
                              child: Text(
                                globals.generalContentArray['next']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 25),
                                elevation: 0.0,
                                backgroundColor: Colors.white.withOpacity(0.05),
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
                              child: Text(
                                globals.generalContentArray['back']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                  : Container(),
            ),
            Expanded(
              flex: timer ? 8 : 5,
              child: logoImg(timer),
            ),
            timer
                ? Expanded(flex: 5, child: welcomeTxt())
                : Expanded(
                    flex: 8,
                    child: loginWidget(context, next, controllerPhone,
                        controllerCode, randomCode),
                  ),
          ],
        ),
        BlocBuilder<NetworkChecker, bool>(
            builder: (context, networkStatus) => !networkStatus
                ? Column(children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<NetworkChecker>(context)
                              .add(CheckInternetConnectionEvent());
                          timerStart();
                        },
                        child: Container(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              1,
                          color: Colors.grey.withOpacity(0.3),
                          child: Center(
                              child:
                                  Text("Network connection: $networkStatus")),
                        ),
                      ),
                    ),
                  ])
                : Container())
      ]),
    );
  }
}
