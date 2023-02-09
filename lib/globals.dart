library uteam.globals;

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> mapController = Completer();
//Settings
String googleApikey = "AIzaSyDp-RK6hvtMgaT6ra-8r9gskR1Sgpm1h88";

//General Data
String language = "";
String phoneNumber = "";
String uulid = "";
String level = "";
bool flag = true; //Determine what position to use (Current or New)

//Current position Data
double latitude = 0.0;
double longitude = 0.0;
String countryIso = "";
String country = "";
String postalCode = "";
String city = "";
String street = "";
String building = "";

//New Object position Data
double newLatitude = 30.723122005126953;
double newLongitude = 2.349999;
String newCountryIso = "";
String newCountry = "";
String newPostalCode = "";
String newCity = "";
String newStreet = "";
String newBuilding = "";

Map<String, String> generalContentArray = {
  'back': '<back',
  'next': 'next>',
  'welcomePageText_1': 'welcome to',
  'logInPhoneText_1': 'enter your\nphone number',
  'logInCodeText_1': 'enter code we\nsended on your\nphone number',
  'mainPageText_1': 'you entered as a guest',
  'addObjPageText_1': 'add new\nobject',
'objDetailsPageText_1': 'location',
'objDetailsPageText_2': 'level',
'objDetailsPageText_4': 'add\nphoto',
'photoPageText_1': 'make\nother\nphoto',
'photoPageText_2': 'use this\n photo',
'objectPageText_1': 'save',
'objectPageText_2': 'edit'
};