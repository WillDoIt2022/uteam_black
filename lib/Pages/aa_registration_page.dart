import 'package:flutter/material.dart';
//import 'dart:async'; //For timer working
import 'dart:math'; //For random number code generator
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/network_checker.dart';
import '../Widgets/logo_img.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "../Widgets/language_determiner.dart";
import "../Widgets/translator.dart";
import '../Widgets/welcome_txt.dart';
import '../styles/app_textstyles.dart';
import '../styles/app_colors.dart';
import '../Widgets/auth.dart';
import "../routes.dart";
import '../globals.dart' as globals;

// ignore_for_file: prefer_const_constructors

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  final controllerEmail = TextEditingController(text: "");
  dynamic controllerPassword = TextEditingController(text: "");
  dynamic controllerRepeatPassword = TextEditingController(text: "");
  dynamic controllerName = TextEditingController(text: "");
  //dynamic timer;
  dynamic signUp;
  bool passwordVisible = false;

  final List<String> itemsLang = [
    'en',
    'fr',
    'ua',
  ];

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    signUp = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: signUp ? 4 : 3,
            child: logoImg(signUp),
          ),
          Expanded(
              flex: signUp ? 6 : 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          //color: Colors.green,
                          child: Text(
                            textAlign: TextAlign.left,
                            "login".toString().toUpperCase(),
                            style: AppTextStyle.textSize13Grey,
                          ),
                        ),
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: controllerEmail,
                            maxLines: 1,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              //filled: true,
                              //fillColor: Colors.deepPurpleAccent,
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 15, 77, 154)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 15, 77, 154)),
                              ),
                              border: InputBorder.none,
                              labelText: '',
                              hintText: '',
                              contentPadding: EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          //color: Colors.green,
                          child: Text(
                            textAlign: TextAlign.left,
                            "password".toString().toUpperCase(),
                            style: AppTextStyle.textSize13Grey,
                          ),
                        ),
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                            controller: controllerPassword,
                            obscureText: !passwordVisible,
                            obscuringCharacter: "*",
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (text) async {
                              if (controllerPassword.text.length == 7) {
                                //Navigator.pushReplacementNamed(context, Routes.mainPage);
                                //await Auth().registerWithEmailAndPassword(controllerPhone.text,controllerCode.text);
                                //Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage,
                                //(Route<dynamic> route) => false);
                              } else {
                                return;
                              }
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              //filled: true,
                              //fillColor: Colors.deepPurpleAccent,
                              isCollapsed: true,
                              //isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 15, 77, 154)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 15, 77, 154)),
                              ),
                              border: InputBorder.none,
                              labelText: '',
                              hintText: '',
                              contentPadding: EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
                              suffixIconConstraints:
                                  BoxConstraints(maxHeight: 30),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.all(0),
                                //alignment: Alignment.center,

                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ]),
                  if (signUp == false)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                0.8,
                            //color: Colors.green,
                            child: Text(
                              textAlign: TextAlign.left,
                              "repeat password".toString().toUpperCase(),
                              style: AppTextStyle.textSize13Grey,
                            ),
                          ),
                          SizedBox(
                            width: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                0.8,
                            child: TextField(
                              style: TextStyle(
                                fontSize: 12,
                                height: 0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                              controller: controllerRepeatPassword,
                              obscureText: true,
                              obscuringCharacter: "*",
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (text) async {
                                if (controllerRepeatPassword.text.length == 7) {
                                  //Navigator.pushReplacementNamed(context, Routes.mainPage);
                                  //await Auth().registerWithEmailAndPassword(controllerPhone.text,controllerCode.text);
                                  //Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage,
                                  //(Route<dynamic> route) => false);
                                } else {
                                  return;
                                }
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                //filled: true,
                                //fillColor: Colors.deepPurpleAccent,
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 77, 154)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 77, 154)),
                                ),
                                border: InputBorder.none,
                                labelText: '',
                                hintText: '',
                                contentPadding: EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
                              ),
                            ),
                          ),
                        ]),
                    if (signUp == false)
                   Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              SizedBox(
                                width: MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .size
                                        .width *
                                    0.8,
                                //color: Colors.green,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "name".toString().toUpperCase(),
                                  style: AppTextStyle.textSize13Grey,
                                ),
                              ),
                              SizedBox(
                                width: MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .size
                                        .width *
                                    0.8,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  controller: controllerName,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  onChanged: (text) async {
                                    if (controllerName.text.length == 7) {
                                      //Navigator.pushReplacementNamed(context, Routes.mainPage);
                                      //await Auth().registerWithEmailAndPassword(controllerPhone.text,controllerCode.text);
                                      //Navigator.pushNamedAndRemoveUntil(context, Routes.mainPage,
                                      //(Route<dynamic> route) => false);
                                    } else {
                                      return;
                                    }
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    //filled: true,
                                    //fillColor: Colors.deepPurpleAccent,
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 15, 77, 154)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 15, 77, 154)),
                                    ),
                                    border: InputBorder.none,
                                    labelText: '',
                                    hintText: '',
                                    contentPadding: EdgeInsets.only(
                                        left: 10, bottom: 10, top: 10),
                                  ),
                                ),
                              ),
                            ])
                     ,
                  if (signUp == false) Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              SizedBox(
                                width: MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .size
                                        .width *
                                    0.8,
                                //color: Colors.green,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "language".toString().toUpperCase(),
                                  style: AppTextStyle.textSize13Grey,
                                ),
                              ),
                              SizedBox(
                                width: MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .size
                                        .width *
                                    0.8,
                                child: DropdownButton2(
                                  buttonWidth: 290,
                                  isExpanded: true,
                                  isDense: true,
                                  underline: Container(
                                    height: 2,
                                    color: Color.fromARGB(255, 124, 160, 209),
                                  ),
                                  value: "en",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 124, 160, 209),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  //menuMaxHeight: 200,
                                  items: itemsLang.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toUpperCase()),
                                    );
                                  }).toList(),

                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color.fromARGB(255, 15, 77, 154),
                                  ),
                                  buttonPadding:
                                      const EdgeInsets.only(left: 15),
                                  dropdownDecoration: BoxDecoration(
                                    //borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(255, 222, 229, 239),
                                  ),

                                  itemHeight: 40,
                                  dropdownMaxHeight: 170,
                                ),
                              ),
                            ])
                      ,
                  SizedBox(
                    height: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        0.1,
                    width: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 250, 184, 108),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        elevation: 1,
                        shadowColor: Color.fromARGB(255, 250, 250, 250),
                      ),
                      onPressed: () async {
                        if (signUp == false) {
                          await Auth().registerWithEmailAndPassword(
                              controllerEmail.text, controllerPassword.text);
                        } else if (signUp == true) {
                          await Auth().signInWithEmailAndPassword(
                              controllerEmail.text, controllerPassword.text);
                        } else {
                          return;
                        }
                        await Auth().authStateChanges().then((value) => value
                            ? Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.mainPage,
                                (Route<dynamic> route) => false)
                            : print(value));
                      },
                      child: Text(
                        signUp
                            ? globals
                                .generalContentArray['logInRegisteredText_1']
                                .toString()
                            : "Sign up",
                        style: AppTextStyle.textSize20Light,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (signUp == true) SizedBox(
                          height: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.1,
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.6,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.middleBlueVar2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              elevation: 1,
                              shadowColor: Color.fromARGB(255, 250, 250, 250),
                            ),
                            onPressed: () async {
                              await Auth()
                                  .signOut()
                                  .then((value) => print(value));
                            },
                            child: Text(
                              globals
                                  .generalContentArray['logInRegisteredText_2']
                                  .toString(),
                              style: AppTextStyle.textSize20Light,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ,
                  SizedBox(
                    width: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          signUp
                              ? "Not registered yet? "
                              : "Already registered? ".toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              signUp = !signUp;
                            });
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            signUp ? "Sign up" : "Log in".toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 15, 77, 154),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
