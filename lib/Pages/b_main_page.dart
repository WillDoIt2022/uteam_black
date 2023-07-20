import 'package:flutter/material.dart';
//packages
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//settings
import '../globals.dart' as globals;
import '../routes.dart';
// ignore_for_file: prefer_const_constructors

class MainPage extends StatefulWidget {
  const MainPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _LaunchApp();
  }
}

class _LaunchApp extends State<MainPage> {
  final docObjects = FirebaseFirestore.instance.collection('objects');
  final translator = GoogleTranslator();

  final List<String> itemsObjects = [
    'grand optical',
    'axe energy',
    'everest',
    'odesa city',
  ];

  @override
  void initState() {
    super.initState();
  }

  void translateLanguage(textt) {
    translator.translate(textt, to: globals.language).then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to Exit?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.transparent, // Image radius
                          backgroundImage: AssetImage(
                              "assets/img/app_img/user/Unnamed_user.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 10, bottom: 0, top: 0),
                          child: Text(
                            globals.userName != ""
                                ? "Hi, ${globals.userName}".toUpperCase()
                                : "Hi, User!".toString().toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 15, 77, 154),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.profilePage);
                          },
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.transparent, // Image radius
                            backgroundImage: AssetImage(
                                "assets/img/app_img/user/Pencil_circle.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Please, select account:".toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 15, 77, 154),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: Center(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 25),
                    // the number of items in the list
                    itemCount: itemsObjects.length,
                    // display each item of the product list
                    itemBuilder: (context, index) {
                      return ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 40, right: 40, bottom: 10, top: 10),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  globals.objectName = itemsObjects[index]
                                      .toString()
                                      .toLowerCase();
                                  globals.accountName = itemsObjects[index]
                                      .toString()
                                      .toLowerCase();
                                  Navigator.pushNamed(
                                      context, Routes.addObjPage);
                                },
                                child: Container(
                                  height: MediaQueryData.fromWindow(
                                              WidgetsBinding.instance.window)
                                          .size
                                          .width *
                                      0.15,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 213, 224, 237),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        itemsObjects[index]
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 96, 146, 204),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]);
                    },
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
