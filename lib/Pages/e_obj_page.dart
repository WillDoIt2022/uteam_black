import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; //Spinner
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'dart:io';
import '../BLoC/obj_details_counter.dart';
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
  var uuid = Uuid();
  String objectId = "";
  late Map<String, dynamic> object = {};

  final docObjects = FirebaseFirestore.instance.collection('objects');
  dynamic onSave;
  String? urlDownloadLink;
  UploadTask? uploadTask;
  String? isPictureDone;
  bool onLoading = false;

  @override
  void initState() {
    super.initState();
    onSave = globals.onSave;
    globals.objectId == '' ? globals.objectId = 'onEdit' : null;
    //Detecting if the picture was done by camera
    // ignore: unnecessary_null_comparison
    widget.picture == null ? isPictureDone = "false" : isPictureDone = "true";
  }

  Future saveObjectPicture() async {
    onLoading = true;
    if (isPictureDone == "true") {
      if (globals.objectId == "onEdit") {
        objectId = uuid.v1();
        globals.objectId = objectId;

        final path = 'images/$objectId.jpg';
        final file = File(widget.picture.path);
        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);

        final snapshot = await uploadTask!.whenComplete(() {});
        urlDownloadLink = await snapshot.ref.getDownloadURL();
      } else if (globals.objectId != "") {
        final path = 'images/${globals.objectId}.jpg';

        final ref = FirebaseStorage.instance.ref().child(path);
// Delete the file
        await ref.delete();
//Create a new one file
        final file = File(widget.picture.path);
        uploadTask = ref.putFile(file);

        final snapshot = await uploadTask!.whenComplete(() {});
        urlDownloadLink = await snapshot.ref.getDownloadURL();
      }
    }
    await updateObject();
    await addNewObject();
  }

  updateObject() {
    setState(() {
      object = {
        "createDate": Timestamp.now(),
        "id": globals.objectId,
        "imgUrl": globals.imgUrl == "" ? urlDownloadLink : globals.imgUrl,
        "phoneNumber": globals.phoneNumber,
        "uulid": globals.uulid.toLowerCase(),
        "latitude": globals.flag ? globals.latitude : globals.newLatitude,
        "longitude": globals.flag ? globals.longitude : globals.newLongitude,
        "countryIso": globals.flag
            ? globals.countryIso.toLowerCase()
            : globals.newCountryIso.toLowerCase(),
        "country": globals.flag
            ? globals.country.toLowerCase()
            : globals.newCountry.toLowerCase(),
        "postalCode": globals.flag
            ? globals.postalCode.toLowerCase()
            : globals.newPostalCode.toLowerCase(),
        "street": globals.flag
            ? globals.street.toLowerCase()
            : globals.newStreet.toLowerCase(),
        "building": globals.flag
            ? globals.building.toLowerCase()
            : globals.newBuilding.toLowerCase(),
        "level": globals.level.toLowerCase(),
      };
    });
  }

  Future addNewObject() async {
    docObjects
        .doc(globals.objectId)
        .set(object)
        .then((value) => dbSuccessfullyStored())
        .onError((e, _) => dbNotStored(e));
  }

  dbSuccessfullyStored() {
    setState(() {
      onLoading = false;
    });

    Flushbar(
      title: 'object'.toUpperCase(),
      titleColor: Colors.green,
      titleSize: 18,
      message: 'successfully saved',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  dbNotStored(e) {
    print("Error writing document: $e");

    setState(() {
      onLoading = false;
    });

    Flushbar(
      title: 'object'.toUpperCase(),
      titleColor: Colors.red,
      titleSize: 18,
      message: 'have not been saved. Try again later',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  goToEdit(data) {
    if (data == "address") {
      //setting navCounter t "0" - first page
      BlocProvider.of<CounterNav>(context).add(CounterResetEvent());
      Navigator.pushNamed(context, Routes.objDetailsPage).then((_) {
        // This block runs when you have returned back to the 1st Page from 2nd.
        setState(() {
          // Call setState to refresh the page.
        });
      });
    } else if (data == "uulid") {
      BlocProvider.of<CounterNav>(context).add(CounterGoToUulidEvent());
      Navigator.pushNamed(context, Routes.objDetailsPage).then((_) {
        setState(() {});
      });
    } else if (data == "photo") {
      globals.imgUrl = "";
      Navigator.pushNamed(context, Routes.photoPage).then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          body: Center(
            child: Stack(
              //alignment: Alignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: onSave
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          onSave
                              ? globals.objectId == ""
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding:
                                            EdgeInsets.only(top: 25, left: 30),
                                        elevation: 0.0,
                                        backgroundColor:
                                            Color.fromARGB(255, 246, 246, 246),
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
                                  : Container()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.only(top: 25, right: 30),
                                    elevation: 0.0,
                                    backgroundColor:
                                        Color.fromARGB(255, 246, 246, 246),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.mainPage,
                                        (Route<dynamic> route) => false);
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
                            InkWell(
                              onTap: () {
                                !onSave ? null : goToEdit("photo");
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: isPictureDone == "true"
                                    ? Image.file(File(widget.picture.path),
                                        fit: BoxFit.cover, width: 200)
                                    : SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Image.network(globals.imgUrl),
                                      ),
                              ),
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
                          InkWell(
                            onTap: () {
                              !onSave ? null : goToEdit("uulid");
                            },
                            child: Container(
                              width: 290,
                              //height: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 0.0),
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
                          ),
                          Container(
                            width: 290,
                            //height: 100,
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              globals
                                  .generalContentArray['objDetailsPageText_1']
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
                          InkWell(
                            onTap: () {
                              !onSave ? null : goToEdit("address");
                            },
                            child: Container(
                              width: 290,
                              //height: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 0.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 124, 160, 209),
                                  ),
                                ),
                              ),
                              child: Text(
                                globals.flag
                                    ? "${globals.street}, ${globals.building}"
                                        .toUpperCase()
                                    : "${globals.newStreet}, ${globals.newBuilding}"
                                        .toUpperCase(),
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
                          ),
                          Container(
                            width: 290,
                            //height: 100,
                            padding: EdgeInsets.only(top: 10),

                            child: Text(
                              globals
                                  .generalContentArray['objDetailsPageText_2']
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
                          InkWell(
                            onTap: () {
                              !onSave ? null : goToEdit("address");
                            },
                            child: Container(
                              width: 290,
                              //height: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 0.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 124, 160, 209),
                                  ),
                                ),
                              ),
                              child: Text(
                                globals.level.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 15, 77, 154),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              onSave
                                  ? SizedBox(
                                    width: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.62,
                                    child:Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.08,
                                          width: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.28,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 222, 229, 239),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              elevation: 1,
                                              shadowColor: Color.fromARGB(
                                                  255, 250, 250, 250),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              globals.generalContentArray[
                                                      'objectPageText_3']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 79, 135, 199),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.08,
                                          width: MediaQueryData.fromWindow(
                                                      WidgetsBinding
                                                          .instance.window)
                                                  .size
                                                  .width *
                                              0.28,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 222, 229, 239),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              elevation: 1,
                                              shadowColor: Color.fromARGB(
                                                  255, 250, 250, 250),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              globals.generalContentArray[
                                                      'objectPageText_4']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 79, 135, 199),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),)
                                  : Container(),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(300, 80),
                                    backgroundColor: onSave
                                        ? Color.fromARGB(255, 124, 160, 209)
                                        : Color.fromARGB(255, 222, 229, 239),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    elevation: 1,
                                    shadowColor:
                                        Color.fromARGB(255, 250, 250, 250),
                                  ),
                                  onPressed: () {
                                    if (onSave == true) {
                                      saveObjectPicture();
                                    }

                                    globals.onSave = true;
                                    setState(() {
                                      onSave = !onSave;
                                    });
                                  },
                                  child: Text(
                                    onSave
                                        ? globals.generalContentArray[
                                                'objectPageText_1']
                                            .toString()
                                            .toUpperCase()
                                        : globals.generalContentArray[
                                                'objectPageText_2']
                                            .toString()
                                            .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: onSave
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromARGB(255, 79, 135, 199),
                                      fontSize: 36,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                  ])),
                    Expanded(flex: 2, child: FooterMenu()),
                  ],
                ),
                onLoading
                    ? Column(
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
                              child: Center(
                                child: LoadingAnimationWidget.twoRotatingArc(
                                  color: Color.fromARGB(255, 15, 77, 154),
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ));
    });
  }
}
