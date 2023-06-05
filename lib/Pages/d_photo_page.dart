import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart'; //Spinner
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:io';
import './e_obj_page.dart';
import '../globals.dart' as globals;

// ignore_for_file: prefer_const_constructors

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LaunchCamera();
  }
}

class _LaunchCamera extends State<PhotoPage> {
  List<CameraDescription> cameras = <CameraDescription>[];
  late CameraController cameraController;

  dynamic isCameraReady;
  dynamic isPictureDone;
  dynamic photo;

  @override
  void initState() {
    isCameraReady = false;
    isPictureDone = false;
    startCamera();
    super.initState();
  }

  Future<void> startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraReady = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future takePicture() async {
    if (!cameraController.value.isInitialized) {
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off);

      XFile picture = await cameraController.takePicture();
      setState(() {
        isPictureDone = true;
        photo = picture;
      });
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isCameraReady
              ? [
                  Expanded(
                    flex: 11,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: Offset(0, 4)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: !isPictureDone
                                          ? CameraPreview(cameraController)
                                          : Image.file(File(photo.path),
                                              fit: BoxFit.cover, width: 200),
                                    ),
                                    !isPictureDone
                                        ? Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 25, left: 30),
                                              child: SizedBox(
                                                width: 150,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 250, 250, 250),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    globals.generalContentArray[
                                                            'back']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 24,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: !isPictureDone
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 15, 77, 154),
                                  width: 2),
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                'assets/svg/CameraButton.svg',
                                color: Color.fromARGB(255, 124, 160, 209),
                              ),
                              padding: EdgeInsets.all(5),
                              iconSize: 60,
                              tooltip: 'Make a photo',
                              onPressed: () {
                                takePicture();
                              },
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "<",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 124, 160, 209),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        backgroundColor:
                                            Color.fromARGB(255, 246, 246, 246),
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            isPictureDone = !isPictureDone;
                                          },
                                        );
                                      },
                                      child: Text(
                                        globals.generalContentArray[
                                                'photoPageText_1']
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 124, 160, 209),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        backgroundColor:
                                            Color.fromARGB(255, 246, 246, 246),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ObjectPage(
                                                      picture: photo,
                                                    )));
                                      },
                                      child: Text(
                                        globals.generalContentArray[
                                                'photoPageText_2']
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 124, 160, 209),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      ">",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 124, 160, 209),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ]
              : [
                  LoadingAnimationWidget.twoRotatingArc(
                    color: Color.fromARGB(255, 15, 77, 154),
                    size: 50,
                  ),
                ],
        )));
  }
}
