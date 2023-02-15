import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes.dart';
// ignore_for_file: prefer_const_constructors

//Widget footerMenu(context) {
class footerMenu extends StatefulWidget {
  const footerMenu({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return footerMenuWidget();
  }
}

class footerMenuWidget extends State<footerMenu> {
  @override
  void initState() {
    super.initState();
  }

  currentUrlDeterminer(path) {
    print("I'm here");
    print(path);
    print(ModalRoute.of(context)?.settings.name.toString());
    if (ModalRoute.of(context)?.settings.name.toString().contains(path) ==
        true) {
      return 50.0;
    } else {
      return 36.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 74, 132, 196),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/svg/Profile.svg'),
            iconSize: 30,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Profile',
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Edit.svg',
                height: currentUrlDeterminer(Routes.dataBasePage)),
            iconSize: 50,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'DataBase of Objects',
            onPressed: () {
              Navigator.pushNamed(context, Routes.dataBasePage);
            },
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Add.svg',
                height: currentUrlDeterminer(Routes.addObjPage)),
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Add Object',
            iconSize: 50,
            onPressed: () {
              //Navigator.pushNamedAndRemoveUntil(context, Routes.addObjPage, (Route<dynamic> route) => false);
              Navigator.pushNamed(context, Routes.addObjPage);
            },
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Geo.svg'),
            iconSize: 30,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Geolocation map',
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Settings.svg'),
            iconSize: 30,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Settings',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
