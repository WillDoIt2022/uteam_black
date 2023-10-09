import 'package:flutter/material.dart';
//packages
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:loading_animation_widget/loading_animation_widget.dart'; //Spinner
import 'dart:math';
import '../Widgets/geocoding.dart';
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
  final docAccounts =
      FirebaseFirestore.instance.collection('users').doc(globals.phoneNumber);
  final docObjects = FirebaseFirestore.instance.collection('objects');
  final translator = GoogleTranslator();

  bool filteredDbflag = globals.usersAccounts.isEmpty ? false : true;
//holds calculatef distance of iterable List of exist object
  num? distance;
  //holds nearest object Lat & Long
  double nearestObjectLatitude = 0.0;
  double nearestObjectLongitude = 0.0;
  dynamic prevNearestObjectDistance = 0;

  @override
  void initState() {
    globals.usersAccounts.isEmpty ? getUserObjects() : null;
    //getUserObjects();
    super.initState();
  }

  Future getUserObjects() async {
    await docAccounts.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var doc = documentSnapshot.data() as Map;
        globals.usersAccounts = doc["accountsAccess"];
        setState(() {
          filteredDbflag = true;
        });
      }
    });
  }

//Getting unique address for current AccountName to display them on the map
  getObjectsLatLang() async {
    await docObjects
        .where("phoneNumber", isEqualTo: globals.phoneNumber.toString())
        .where("accountName", isEqualTo: globals.accountName.toString())
        .get()
        .then((QuerySnapshot snapshot) {
      var filteredDb = snapshot.docs.toList();

      var seen = Set<String>();
      var uniquelist = filteredDb
          .where((x) =>
              seen.add(x["latitude"].toString() + x["longitude"].toString()))
          .toList();
      globals.existAddressesInAccount = uniquelist;
      print(filteredDb.length);
      print(uniquelist.length);

      for (var i = 0; i < uniquelist.length; i++) {
        distanceToObject(uniquelist[i]["latitude"], uniquelist[i]["longitude"]);
        print("distance");
        print(distance);
        if (i == 0 && distance == 0) {
          prevNearestObjectDistance = 0;
        } else if (i == 0 && distance != 0) {
          prevNearestObjectDistance = distance;
        }

        if (distance! <= prevNearestObjectDistance) {
          prevNearestObjectDistance = distance;
          nearestObjectLatitude = uniquelist[i]["latitude"];
          nearestObjectLongitude = uniquelist[i]["longitude"];
        }
       
        //print(uniquelist[i]["latitude"]);
        //print(uniquelist[i]["longitude"]);
        //print(uniquelist[i]["id"]);
      }
       if (uniquelist.isNotEmpty) {
          print("Im setting a new address!!!!!!!!!!!!");
          print(globals.flag);
          print(nearestObjectLatitude);
          print(nearestObjectLongitude);
          globals.flag = false;
          globals.newLatitude = nearestObjectLatitude;
          globals.newLongitude =
              nearestObjectLongitude;
          convertToAddress().then((value) {
            setState(() {});
          });
        }
    });
  }

  double distanceToObject(lat1, lon1) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((globals.latitude - lat1) * p) / 2 +
        cos(lat1 * p) *
            cos(globals.latitude * p) *
            (1 - cos((globals.longitude - lon1) * p)) /
            2;
    return distance = 12742 * asin(sqrt(a));
  }

  void translateLanguage(textt) {
    translator.translate(textt, to: globals.language).then((result) {
      setState(() {});
    });
  }

  deniedNotification() {
    Flushbar(
      title: 'object'.toUpperCase(),
      titleColor: Colors.red,
      titleSize: 18,
      message: 'Sorry, but you have no access to this account',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
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
        body: Stack(children: [
          Column(
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
                              Navigator.pushNamed(context, Routes.profilePage)
                                  .then((_) {
                                // This block runs when you have returned back to the 1st Page from 2nd.
                                setState(() {
                                  // Call setState to refresh the page.
                                });
                              });
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  Colors.transparent, // Image radius
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
                    itemCount: globals.usersAccounts.length,
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
                                  if (globals.usersAccounts[index]["access"] ==
                                      true) {
                                    globals.objectName = globals
                                        .usersAccounts[index]["name"]
                                        .toString()
                                        .toLowerCase();
                                    globals.accountName = globals
                                        .usersAccounts[index]["name"]
                                        .toString()
                                        .toLowerCase();
                                    getObjectsLatLang();
                                    Navigator.pushNamed(
                                        context, Routes.addObjPage);
                                  } else {
                                    deniedNotification();
                                  }
                                },
                                child: Container(
                                  height: MediaQueryData.fromWindow(
                                              WidgetsBinding.instance.window)
                                          .size
                                          .width *
                                      0.15,
                                  decoration: BoxDecoration(
                                    color: globals.usersAccounts[index]
                                            ["access"]
                                        ? Color.fromARGB(255, 79, 135, 199)
                                        : Color.fromARGB(255, 147, 184, 226),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        globals.usersAccounts[index]["name"]
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: globals.usersAccounts[index]
                                                  ["access"]
                                              ? Color.fromARGB(255, 27, 82, 157)
                                              : Color.fromARGB(
                                                  255, 79, 135, 199),
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
                  ))),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
          !filteredDbflag
              ? Container(
                  width:
                      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                              .size
                              .width *
                          1,
                  color: Colors.grey.withOpacity(0.3),
                  child: Center(
                    child: LoadingAnimationWidget.twoRotatingArc(
                      color: Color.fromARGB(255, 15, 77, 154),
                      size: 50,
                    ),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
