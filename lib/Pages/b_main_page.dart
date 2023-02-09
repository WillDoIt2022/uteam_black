import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../globals.dart' as globals;
import '../Widgets/logo_img.dart';
import '../Widgets/footer_menu.dart';
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
  final docObjects =
        FirebaseFirestore.instance.collection('objects');
  //final docObjects =
        //FirebaseFirestore.instance.collection('objects').doc(globals.phoneNumber);
  final translator = GoogleTranslator();
  dynamic timer;
  @override
  void initState() {
    super.initState();
    timer = true;
  }

  void translateLanguage(textt) {
    translator.translate(textt, to: globals.language).then((result) {
      setState(() {});
    });
  }


//Future addObject() async {
  //docObjects
    //.set({'city': 'Berlin'},SetOptions(merge: true))
    //.onError((e, _) => print("Error writing document: $e"));
//}

Future addNewUser() async {

final query = docObjects.where("city", isEqualTo: "Berlin").get().then((QuerySnapshot snapshot){
  snapshot.docs.forEach((element) {
    print(element.data());
  });
}
    );
  //docObjects
    //.set({'city': 'Berlin'}).then(
    //(value) => print(docObjects)).onError((e, _) => print("Error writing document: $e"));
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
              flex: 10,
              child: logoImg(timer),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  globals.generalContentArray['mainPageText_1']
                      .toString()
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 124, 160, 209),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: footerMenu(context),
            ),
          ],
        ),
      ),
    );
  }
}
