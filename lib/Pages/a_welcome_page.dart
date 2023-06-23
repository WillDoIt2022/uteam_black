import 'package:flutter/material.dart';
//import 'dart:async'; //For timer working
import 'dart:math'; //For random number code generator
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/network_checker.dart';
import '../Widgets/logo_img copy.dart';
import "../Widgets/language_determiner.dart";
import "../Widgets/translator.dart";
import '../Widgets/welcome_txt.dart';
import '../globals.dart' as globals;
import '../routes.dart';

// ignore_for_file: prefer_const_constructors

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _LaunchApp();
  }
}

class _LaunchApp extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final controllerPhone = TextEditingController(text: "");
  dynamic controllerCode = TextEditingController(text: "");
  dynamic selectLang;

  final List<String> itemsLang = [
    'en',
    'fr',
    'ua',
  ];

  late AnimationController controller;
  late Animation<double> animation;
  //late Animation<double> animationElements;
  //late AnimationController controllerElements;
  //late Animation<double> animationElements;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NetworkChecker>(context)
        .add(CheckInternetConnectionEvent());
    selectLang = false;
        //controllerElements =
        //AnimationController(duration: Duration(seconds: 2), vsync: this);
    //animationElements = CurvedAnimation(parent: controller, curve: Curves.linear);
   // controllerElements.forward();
    //Logo animation
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();

    timer();
  }

  timer() async {
    await Future.delayed(Duration(milliseconds: 5000));
    //Reffers to Registration Form
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.registrationPage, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkChecker, dynamic>(
        builder: (context, networkStatus) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                0.24,
                            padding: const EdgeInsets.only(top: 25),
                            child: IconButton(
                              icon: Image.asset(
                                  'assets/img/app_img/lang/${globals.selectedLanguage}_flag.png'),
                              iconSize: 50,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                setState(
                                  () {
                                    selectLang = !selectLang;
                                    print(globals.language);
                                  },
                                );
                              },
                            ),
                          ),
                        ])),
                Expanded(
                  flex: 4,
                  child: logoImg(true, animation,controller),
                ),
                Expanded(flex: 6, child: welcomeTxt(animation, controller))
              ],
            ),
            networkStatus == false
                ? Column(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQueryData.fromWindow(
                                    WidgetsBinding.instance.window)
                                .size
                                .width *
                            1,
                        color: Colors.grey.withOpacity(0.3),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 200),
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 246, 246, 246),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 1,
                                  shadowColor:
                                      Color.fromARGB(255, 250, 250, 250),
                                ),
                                onPressed: () {
                                  BlocProvider.of<NetworkChecker>(context)
                                      .add(CheckInternetConnectionEvent());
                                },
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Network connection\nfailed"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 15, 77, 154),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Please, check your connection and try again"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 124, 160, 209),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])
                : selectLang
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .size
                                        .width *
                                    1,
                                color: Colors.grey.withOpacity(0.3),
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(top: 25),
                                    // the number of items in the list
                                    itemCount: itemsLang.length,
                                    // display each item of the product list
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: MediaQueryData.fromWindow(
                                                    WidgetsBinding
                                                        .instance.window)
                                                .size
                                                .width *
                                            0.1,
                                        margin: EdgeInsets.only(
                                          left: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.72,
                                          right: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                index == 0 ? 20.0 : 0),
                                            topLeft: Radius.circular(
                                                index == 0 ? 20.0 : 0),
                                            bottomRight: Radius.circular(
                                                index == itemsLang.length - 1
                                                    ? 20.0
                                                    : 0),
                                            bottomLeft: Radius.circular(
                                                index == itemsLang.length - 1
                                                    ? 20.0
                                                    : 0),
                                          ),
                                          color:
                                              Color.fromARGB(255, 79, 135, 199),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              itemsLang[index]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            IconButton(
                                              icon: Image.asset(
                                                  'assets/img/app_img/lang/${itemsLang[index].toString()}_flag.png'),
                                              iconSize: 50,
                                              constraints: BoxConstraints(),
                                              onPressed: () async {
                                                globals.language =
                                                    itemsLang[index].toString();
                                                globals.selectedLanguage =
                                                    itemsLang[index].toString();

                                                languageDeterminer();
                                                await translateLanguage();
                                                await Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  selectLang = !selectLang;
                                                  setState(() {});
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ])
                    : Container(),
          ]));
    });
  }
}
