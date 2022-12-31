import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  dynamic timer;
  @override
  void initState() {
    super.initState();
    timer = true;
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 58, 63),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  SizedBox(
                    width: timer ? 390 : 252,
                    height: timer ? 390 : 257,
                  ),
                  Positioned(
                    right: timer ? 18 : 15,
                    top: 0,
                    child: Container(
                      width: timer ? 390 : 252,
                      height: timer ? 390 : 257,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/Logo_guy.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: timer ? 30 : 20,
                    top: timer ? 45 : 25,
                    child: Container(
                      width: timer ? 139 : 89,
                      height: timer ? 140 : 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/Logo_house.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: timer ? 30 : 15,
                    top: timer ? 170 : 120,
                    child: Container(
                      width: timer ? 37 : 24,
                      height: timer ? 37 : 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/Logo_dashbord.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: timer ? 55 : 40,
                    top: timer ? 190 : 130,
                    child: Container(
                      width: timer ? 85 : 55,
                      height: timer ? 85 : 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/Logo_box.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              //color:Color.fromARGB(255, 84, 54, 250),
              //padding: EdgeInsets.only(top: 50),
              child: Align(
            alignment: Alignment.center,
              child: Text(
                "you entered as a guest".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.43),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              //color:Color.fromARGB(255, 241, 111, 111),
              //padding: EdgeInsets.only(top:50),
              //color: Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset('/svg/Profile.svg'),
                    iconSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('/svg/Edit.svg'),
                    iconSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('/svg/Add.svg'),
                    iconSize: 36,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('/svg/Geo.svg'),
                    iconSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('/svg/Settings.svg'),
                    iconSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ]
            // ignore: prefer_const_literals_to_create_immutables

            ));
  }
}
