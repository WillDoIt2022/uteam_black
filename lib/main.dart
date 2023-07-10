import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'BLoC/obj_details_counter.dart';
import 'BLoC/network_checker.dart';
import 'Pages/a_welcome_page.dart';
import 'Pages/aa_registration_page.dart';
import 'Pages/b_main_page.dart';
import 'Pages/e1_add_obj.dart';
import 'Pages/e2_obj_details.dart';
import 'Pages/e4_photo_page.dart';
import 'Pages/e3_obj_location.dart';
import 'Pages/e5_obj_page.dart';
import 'Pages/d_obj_database.dart';
import "./Pages/c_profile_page.dart";
import "routes.dart";
import 'globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

Future main() async {
  //Initializing acces to cameras.
  WidgetsFlutterBinding.ensureInitialized();
  //Initializing .env file
  await dotenv.load(fileName: "assets/.env");
  //Initializing Database when starting the application.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
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
    globals.selectedLanguage = "en";
    //determinePosition();
    super.initState();
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
          create: (context) => NetworkChecker(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
        initialRoute: '/',
        title: "UTEAM",
        routes: {
          Routes.welcomePage: (BuildContext context) => WelcomePage(),
          Routes.registrationPage: (BuildContext context) => RegistrationPage(),
          Routes.mainPage: (BuildContext context) => MainPage(),
          Routes.profilePage: (BuildContext context) => ProfilePage(),
          Routes.addObjPage: (BuildContext context) => AddObjPage(),
          Routes.objDetailsPage: (BuildContext context) => ObjDetailsPage(),
          Routes.objLocation: (BuildContext context) => ObjLocation(
              currentPositionOnMap: currentPositionOnMap,
              toShowAddress: toShowAddress,
              onEditAdress: onEditAdress),
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
