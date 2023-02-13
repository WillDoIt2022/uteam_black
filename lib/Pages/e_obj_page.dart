import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../globals.dart' as globals;
import '../Widgets/footer_menu.dart';
import '../routes.dart';

class ObjectPage extends StatefulWidget {
  const ObjectPage({Key? key, required this.picture}) : super(key: key);
  final XFile picture;

  @override
  State<StatefulWidget> createState() {
    return _ObjSummary();
  }
}

class _ObjSummary extends State<ObjectPage> {
  final object = {
    "createDate": Timestamp.now(),
    "phoneNumber": globals.phoneNumber,
    "uulid": globals.uulid,
    "latitude": globals.flag?globals.latitude:globals.newLatitude,
    "longitude": globals.flag?globals.longitude:globals.newLongitude,
    "countryIso": globals.flag ? globals.countryIso : globals.newCountryIso,
    "country": globals.flag ? globals.country : globals.newCountry,
    "postalCode": globals.flag ? globals.postalCode : globals.newPostalCode,
    "street": globals.flag ? globals.street : globals.newStreet,
    "building": globals.flag ? globals.building : globals.newBuilding,
    "level": globals.level,
  };
  final docObjects = FirebaseFirestore.instance.collection('objects').doc();
  dynamic onSave;
  dynamic street = globals.flag ? globals.street : globals.newStreet;
  dynamic building = globals.flag ? globals.building : globals.newBuilding;

  @override
  void initState() {
    super.initState();
    onSave = true;
  }

  Future addNewObject() async {
    docObjects
        .set(object)
        .then((value) => print(docObjects))
        .onError((e, _) => print("Error writing document: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Center(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment:
                  onSave ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                onSave
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 25, left: 30),
                          elevation: 0.0,
                          backgroundColor: Color.fromARGB(255, 246, 246, 246),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
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
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 25, right: 30),
                          elevation: 0.0,
                          backgroundColor: Color.fromARGB(255, 246, 246, 246),
                        ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.mainPage, (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'X'.toUpperCase(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 15, 77, 154),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.file(File(widget.picture.path),
                        fit: BoxFit.cover, width: 200),
                  ),
                  const SizedBox(height: 24),
                  //Text(picture.name),
                ]),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 290,
                  //height: 100,
                  child: Text(
                    "uulid".toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 124, 160, 209),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  //height: 100,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2.0,
                        color: Color.fromARGB(255, 124, 160, 209),
                      ),
                    ),
                  ),
                  child: Text(
                    globals.uulid.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 15, 77, 154),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  //height: 100,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    globals.generalContentArray['objDetailsPageText_1']
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 124, 160, 209),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  //height: 100,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2.0,
                        color: Color.fromARGB(255, 124, 160, 209),
                      ),
                    ),
                  ),
                  child: Text(
                    "$street. $building".toUpperCase(),
                    //overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 15, 77, 154),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  //height: 100,
                  padding: EdgeInsets.only(top: 10),

                  child: Text(
                    globals.generalContentArray['objDetailsPageText_2']
                        .toString()
                        .toUpperCase(),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 124, 160, 209),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  //height: 100,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2.0,
                        color: Color.fromARGB(255, 124, 160, 209),
                      ),
                    ),
                  ),
                  child: Text(
                    globals.level,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 15, 77, 154),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 80),
                  backgroundColor: onSave
                      ? Color.fromARGB(255, 124, 160, 209)
                      : Color.fromARGB(255, 76, 78, 82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 1,
                  shadowColor: Color.fromARGB(255, 250, 250, 250),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  if (onSave == true) {
                    addNewObject();
                    setState(() {
                      onSave = !onSave;
                    });
                  } else {
                    return;
                  }
                },
                child: Text(
                  onSave
                      ? globals.generalContentArray['objectPageText_1']
                          .toString()
                          .toUpperCase()
                      : globals.generalContentArray['objectPageText_2']
                          .toString()
                          .toUpperCase(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(flex: 2, child: footerMenu(context)),
        ],
      )),
    );
  }
}
