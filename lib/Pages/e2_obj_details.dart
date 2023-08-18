import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart'; //for switch case usage
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:text_tools/text_tools.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:permission_handler/permission_handler.dart';
import '../BLoC/obj_details_counter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'e3_obj_location.dart';
import '../routes.dart';
import '../globals.dart' as globals;
import '../Widgets/uulid_api.dart'; //fetch uulid DB
// ignore_for_file: prefer_const_constructors

class ObjDetailsPage extends StatefulWidget {
  const ObjDetailsPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return ObjDetails();
  }
}

class ObjDetails extends State<ObjDetailsPage> with WidgetsBindingObserver {
  bool currentPositionOnMap = false;
  bool cameraPermissionStatus = false;

  // Initial Selected Value
  String dropdownLevelValue =
      globals.level == "" ? 'ground floor' : globals.level;
  String dropdownUULIDValue =
      globals.uulid == "" ? globals.uulidDB[0] : globals.uulid;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    currentPositionOnMap = false;
    checkCameraPermissions();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  checkCameraPermissions() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is denined.");
    } else if (status.isGranted) {
      //permission is already granted.
      print("Permission is already granted.");
      setState(() {
        cameraPermissionStatus = false;
      });
    } else if (status.isPermanentlyDenied) {
      //permission is permanently denied.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is permanently denied");
    } else if (status.isRestricted) {
      //permission is OS restricted.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is OS restricted.");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkCameraPermissions();
    }
  }

  // List of items in our Level dropdown menu
  var itemsFloor = [
    'ground floor',
    '1st floor',
    '2nd floor',
    '3d floor',
    '5th floor',
    '6th floor',
    '7th floor',
    '8th floor',
    '9th floor',
    '10th floor',
  ];

  // List of items in our UULID dropdown menu
  //globals.uulidDB[0]["Label_FR"],
  var itemsuulid = globals.uulidDB;

  _goToGooleMapPage(toShowAddress, onEditAdress) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjLocation(
                    currentPositionOnMap: currentPositionOnMap,
                    toShowAddress: toShowAddress,
                    onEditAdress: onEditAdress)))
        .then((val) => val ? _toUpdateWidget() : null);
  }

  _toUpdateWidget() async {
    setState(() {
      BlocProvider.of<CounterNav>(context).add(CounterResetEvent());
    });
  }

  noAdressNotification() {
    Flushbar(
      title: 'object'.toUpperCase(),
      titleColor: Colors.red,
      titleSize: 18,
      message: 'Building number should be set',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 25, left: 30),
                          elevation: 0.0,
                          backgroundColor: Colors.white.withOpacity(0.05),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (globals.objectId == "") {
                                if (counter == 0) {
                                  Navigator.pop(context);
                                } else {
                                  BlocProvider.of<CounterNav>(context)
                                      .add(CounterDecrementEvent());
                                }
                              } else {
                                Navigator.pop(context);
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
                      counter != 2 && globals.objectId == ""
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 25, right: 30),
                                elevation: 0.0,
                                backgroundColor: Colors.white.withOpacity(0.05),
                              ),
                              onPressed: () {
                                print(counter);
                                setState(
                                  () {
                                    if (counter == 0) {
                                      currentPositionOnMap = true;
                                      globals.level = dropdownLevelValue;
                                    }
                                    if (counter == 1) {
                                      //if adding a new object
                                      globals.uulid = dropdownUULIDValue;
                                    }
                                    if (counter < 2) {
                                      BlocProvider.of<CounterNav>(context)
                                          .add(CounterIncrementEvent());
                                    } else {
                                      return;
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
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Column(
                    children: ConditionalSwitch.list<int>(
                      context: context,
                      valueBuilder: (BuildContext context) =>
                          int.parse('$counter'),
                      caseBuilders: {
                        0: (BuildContext context) => <Widget>[
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          child: Align(
                                            heightFactor: 1,
                                            widthFactor: 1,
                                            child: ObjLocation(
                                                currentPositionOnMap:
                                                    currentPositionOnMap,
                                                toShowAddress: false,
                                                onEditAdress: false),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<CounterNav>(context)
                                                .add(CounterIncrementEvent());
                                            _goToGooleMapPage(true, false);
                                          },
                                          child: Align(
                                            heightFactor: 0.8,
                                            widthFactor: 0.8,
                                            child: Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 290,
                                        height: 16,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            globals.generalContentArray[
                                                    'objDetailsPageText_1']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 124, 160, 209),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 290,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 2.0,
                                              color: Color.fromARGB(
                                                  255, 124, 160, 209),
                                            ),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<CounterNav>(context)
                                                .add(CounterDecrementEvent());
                                            _goToGooleMapPage(false, true);
                                          },
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  globals.flag
                                                      ? "${globals.street}, ${globals.building}"
                                                      : TextTools
                                                          .toUppercaseFirstLetter(
                                                              text:
                                                                  "${globals.newStreet}, ${globals.newBuilding}"),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 15, 77, 154),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 290,
                                        height: 14,
                                      ),
                                      SizedBox(
                                        width: 290,
                                        height: 16,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            globals.generalContentArray[
                                                    'objDetailsPageText_2']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 124, 160, 209),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 290,
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 290,
                                        height: 30,
                                        child: DropdownButton2(
                                          buttonWidth: 290,
                                          buttonPadding:
                                              const EdgeInsets.only(left: 15),
                                          isExpanded: true,
                                          isDense: true,
                                          // Initial Value
                                          underline: Container(
                                            height: 2,
                                            color: Color.fromARGB(
                                                255, 124, 160, 209),
                                          ),
                                          value: dropdownLevelValue,

                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 15, 77, 154),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154)),

                                          dropdownMaxHeight: 200,
                                          dropdownDecoration: BoxDecoration(
                                            //borderRadius: BorderRadius.circular(30),
                                            color: Color.fromARGB(
                                                255, 222, 229, 239),
                                          ),
                                          // Array list of items
                                          items: itemsFloor.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items.toUpperCase()),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownLevelValue = newValue!;
                                              globals.level = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: MediaQueryData.fromWindow(
                                                          WidgetsBinding
                                                              .instance.window)
                                                      .size
                                                      .width *
                                                  0.1,
                                              width: MediaQueryData.fromWindow(
                                                          WidgetsBinding
                                                              .instance.window)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 250, 184, 108),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  elevation: 1,
                                                  shadowColor: Color.fromARGB(
                                                      255, 250, 250, 250),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  globals.generalContentArray[
                                                          'objDetailsPageText_3']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ],
                                  )),
                            ],
                        1: (BuildContext context) => <Widget>[
                              Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQueryData.fromWindow(
                                                WidgetsBinding.instance.window)
                                            .size
                                            .width *
                                        0.5,
                                    width: MediaQueryData.fromWindow(
                                                WidgetsBinding.instance.window)
                                            .size
                                            .width *
                                        1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/app_img/Main_pic_2.PNG'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'UULID',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Color.fromARGB(255, 15, 77, 154),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    
                                  children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      globals.uulidDB.isEmpty
                                          ? ElevatedButton.icon(
                                              onPressed: () async {
                                                await getUULID(1,1).then(
                                                    (value) => value
                                                        ? setState(() {})
                                                        : print(
                                                            "no data fetched"));
                                              },
                                              icon: Icon(
                                                Icons.refresh,
                                                size: 24.0,
                                              ),
                                              label:
                                                  Text('GET UULID'), // <-- Text
                                            )
                                          : SizedBox(
                                              width: 290,
                                              height: 30,
                                              child: DropdownButton2(
                                                buttonWidth: 290,
                                                isExpanded: true,
                                                isDense: true,
                                                underline: Container(
                                                  height: 2,
                                                  color: Color.fromARGB(
                                                      255, 124, 160, 209),
                                                ),
                                                value: dropdownUULIDValue,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 124, 160, 209),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                //menuMaxHeight: 200,
                                                items: itemsuulid
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                        items.toUpperCase()),
                                                  );
                                                }).toList(),

                                                onChanged: (value) {
                                                  print(itemsuulid.indexOf(
                                                          value ?? 'default') +
                                                      1);
                                                      final userChoice=itemsuulid.indexOf(
                                                          value ?? 'default') +
                                                      1;
                                                      getUULID(userChoice, 1);
                                                  setState(() {
                                                    dropdownUULIDValue =
                                                        value as String;
                                                    globals.uulid = value;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Color.fromARGB(
                                                      255, 15, 77, 154),
                                                ),
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 15),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(30),
                                                  color: Color.fromARGB(
                                                      255, 222, 229, 239),
                                                ),

                                                itemHeight: 40,
                                                dropdownMaxHeight: 170,
                                              ),
                                            )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     if (globals.uulidDB.isNotEmpty) 
                                          SizedBox(
                                              width: 290,
                                              height: 30,
                                              child: DropdownButton2(
                                                buttonWidth: 290,
                                                isExpanded: true,
                                                isDense: true,
                                                underline: Container(
                                                  height: 2,
                                                  color: Color.fromARGB(
                                                      255, 124, 160, 209),
                                                ),
                                                value: dropdownUULIDValue,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 124, 160, 209),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                //menuMaxHeight: 200,
                                                items: itemsuulid
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                        items.toUpperCase()),
                                                  );
                                                }).toList(),

                                                onChanged: (value) {
                                                  print(itemsuulid.indexOf(
                                                          value ?? 'default') +
                                                      1);
                                                      final userChoice=itemsuulid.indexOf(value ?? 'default') +
                                                      1;
                                                      getUULID(userChoice, 2);
                                                  setState(() {
                                                    dropdownUULIDValue =
                                                        value as String;
                                                    globals.uulid = value;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Color.fromARGB(
                                                      255, 15, 77, 154),
                                                ),
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 15),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(30),
                                                  color: Color.fromARGB(
                                                      255, 222, 229, 239),
                                                ),

                                                itemHeight: 40,
                                                dropdownMaxHeight: 170,
                                              ),
                                            )
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                        2: (BuildContext context) => <Widget>[
                              Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQueryData.fromWindow(
                                                WidgetsBinding.instance.window)
                                            .size
                                            .width *
                                        0.5,
                                    width: MediaQueryData.fromWindow(
                                                WidgetsBinding.instance.window)
                                            .size
                                            .width *
                                        1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/app_img/Main_pic_2.PNG'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    
                                    style: ElevatedButton.styleFrom(
                                      
                                      //minimumSize: Size(300, 200),????????????????????????
                                      backgroundColor:
                                          Color.fromARGB(255, 212, 223, 236),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 4,
                                      shadowColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.photoPage);
                                    },
                                    child: Text(
                                      globals.generalContentArray[
                                              'objDetailsPageText_4']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 15, 77, 154),
                                        fontSize: 32,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                      },
                      fallbackBuilder: (BuildContext context) => <Widget>[
                        Text('Uuups, no such page found'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: globals.objectId == ""
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.black.withOpacity(0.0),
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.circle,
                                  color: (counter == 0)
                                      ? Color.fromARGB(255, 15, 77, 154)
                                      : Color.fromARGB(255, 124, 160, 209),
                                  size: 22),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.black.withOpacity(0.0),
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.circle,
                                  color: (counter == 1)
                                      ? Color.fromARGB(255, 15, 77, 154)
                                      : Color.fromARGB(255, 124, 160, 209),
                                  size: 22),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.black.withOpacity(0.0),
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.circle,
                                  color: (counter == 2)
                                      ? Color.fromARGB(255, 15, 77, 154)
                                      : Color.fromARGB(255, 124, 160, 209),
                                  size: 22),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
            counter == 2
                ? cameraPermissionStatus
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 1,
                                      shadowColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                    ),
                                    onPressed: () {
                                      openAppSettings();
                                    },
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Camera permission is not granted"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Please, give access to App"
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
                        )
                      ])
                    : Container()
                : Container()
          ]));
    });
  }
}
