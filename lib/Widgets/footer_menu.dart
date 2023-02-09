import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes.dart';
// ignore_for_file: prefer_const_constructors

Widget footerMenu(context) {
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
          icon: SvgPicture.asset('assets/svg/Edit.svg'),
          iconSize: 30,
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
          tooltip: 'DataBase of Objects',
          onPressed: () {
            Navigator.pushNamed(context, Routes.dataBasePage);
          },
        ),
        IconButton(
          icon: SvgPicture.asset('assets/svg/Add.svg'),
          iconSize: 36,
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
          tooltip: 'Add Object',
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
