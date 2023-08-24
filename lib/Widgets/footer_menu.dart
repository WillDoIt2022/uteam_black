import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes.dart';
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

//Widget footerMenu(context) {
class FooterMenu extends StatefulWidget {
  const FooterMenu({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return FooterMenuWidget();
  }
}

class FooterMenuWidget extends State<FooterMenu> {
  @override
  void initState() {
    super.initState();
  }

  currentUrlDeterminer(path) {
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
            icon: SvgPicture.asset('assets/svg/Profile.svg',
                height: currentUrlDeterminer(Routes.profilePage)),
            iconSize: 50,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.pushNamed(context, Routes.profilePage);
            },
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
              //if (ModalRoute.of(context)?.settings.name =="/main_page") {
              // notification();
              // return;
              // } else {
              // globals.objectId == "";
              // globals.objectName = "";
              // Navigator.pushNamed(context, Routes.addObjPage);
              // }
              //Navigator.pushNamedAndRemoveUntil(context, Routes.addObjPage, (Route<dynamic> route) => false);
              globals.objectId == "";
              globals.fullPath== "";
              Navigator.pushNamed(context, Routes.addObjPage);
            },
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Geo.svg'),
            iconSize: 50,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Geolocation map',
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svg/Settings.svg'),
            iconSize: 50,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            tooltip: 'Settings',
            onPressed: () { },
          ),
        ],
      ),
    );
  }
}
