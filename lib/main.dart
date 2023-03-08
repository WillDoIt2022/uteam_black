import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'BLoC/obj_details_counter.dart';
import'BLoC/network_checker.dart';
import 'Widgets/geocoding.dart';
import 'Pages/a_welcome_page.dart';
import 'Pages/b_main_page.dart';
import 'Pages/c1_add_obj.dart';
import 'Pages/c2_obj_details.dart';
import 'Pages/d_photo_page.dart';
import 'Pages/c2_obj_location.dart';
import 'Pages/e_obj_page.dart';
import './Pages/f_obj_database.dart';
import "routes.dart";
import 'globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

Future main() async {
  //Initializing Database when starting the application.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Launch();
  }
}

class _Launch extends State<MyApp> {
  dynamic picture;
  dynamic currentPositionOnMap;
  dynamic toShowAddress;
dynamic onEditAdress;

  @override
  void initState() {
    
    
    //determinePosition();
    super.initState();
  }

  

  determinePosition() async {
    

    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      globals.latitude = position.latitude;
      globals.longitude = position.longitude;
    });

    convertToAddress();
    //addObject();
  }

  @override
  Widget build(BuildContext context) {
    globals.mapController =
        Completer(); //initializing our controller for google maps.

    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterNav>(
          create: (context) => CounterNav(),
          
        ),
        BlocProvider<NetworkChecker>(
          create: (context) => NetworkChecker(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
        initialRoute: '/',
        title: "UTEAM",
        routes: {
          Routes.welcomePage: (BuildContext context) => WelcomePage(),
          Routes.mainPage: (BuildContext context) => MainPage(),
          Routes.addObjPage: (BuildContext context) => AddObjPage(),
          Routes.objDetailsPage: (BuildContext context) => ObjDetailsPage(),
          Routes.objLocation: (BuildContext context) =>
              ObjLocation(currentPositionOnMap: currentPositionOnMap, toShowAddress:toShowAddress,onEditAdress:onEditAdress),
          Routes.photoPage: (BuildContext context) => PhotoPage(),
          Routes.objectPage: (BuildContext context) => ObjectPage(
                picture: picture,
              ),
Routes.dataBasePage: (BuildContext context) => DataBasePage(),
              
        },
      ),
    );
  }
}
