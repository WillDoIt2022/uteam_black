import 'package:flutter/material.dart';
//packages
import 'package:flutter_bloc/flutter_bloc.dart';
//logic
import '../BLoC/network_checker.dart';
//widgets
import '../Widgets/logo_img_copy.dart';
import '../Widgets/welcome_txt.dart';
//settings
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

class _LaunchApp extends State<WelcomePage> with TickerProviderStateMixin {


  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //starting checking network connection
    BlocProvider.of<NetworkChecker>(context)
        .add(CheckInternetConnectionEvent());
    //Logo animation
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  navigateToLoginPage() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
 Navigator.pushNamedAndRemoveUntil(
        context, Routes.registrationPage, (Route<dynamic> route) => false);
});
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkChecker, dynamic>(
        builder: (context, networkStatus) {
      if (networkStatus == true) {

        navigateToLoginPage();
      }
      
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: logoImg(true, animation),
                ),
                Expanded(flex: 6, child: welcomeTxt(animation))
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
                : Container(),
          ]));
    });
  }
}
