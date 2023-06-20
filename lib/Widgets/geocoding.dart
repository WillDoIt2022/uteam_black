import 'package:dio/dio.dart';
import 'language_determiner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './translator.dart';
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

convertToAddress() async {
    Dio dio = Dio(); //initilize dio package

    double lat = globals.flag?globals.latitude:globals.newLatitude;
    double long = globals.flag?globals.longitude:globals.newLongitude;
    String apikey = dotenv.env['GOOGLE_APIKEY']!;
      dynamic address = "";

    String apiurl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey";

    Response response = await dio.get(apiurl); //send get request to API URL

    if (response.statusCode == 200) {
      //if connection is successful
      Map data = response.data; //get response data
      if (data["status"] == "OK") {
        //if status is "OK" returned from REST API
        if (data["results"].length > 0) {
          //if there is atleast one address
          Map firstresult = data["results"][0]; //select the first address
          address = firstresult["address_components"]; //get the address

if(globals.flag){
for (var i = 0; i < address.length; i++) {
          if (address[i]['types'][0] == 'country') {
            // uncomment this for auto lang translator
            //globals.language = address[i]["short_name"].toLowerCase();
            globals.countryIso = address[i]["short_name"];
            globals.country = address[i]["long_name"];
            // uncomment this for auto lang translator
            //languageDeterminer();
            //translateLanguage();
          } else if (address[i]['types'][0] == 'postal_code') {
            globals.postalCode = address[i]["long_name"];
          } else if (address[i]['types'][0] == 'locality') {
            globals.city = address[i]["long_name"];
          } else if (address[i]['types'][0] == 'route') {
            globals.street = address[i]["short_name"];
          } else if (address[i]['types'][0] == 'street_number') {
            globals.building = address[i]["long_name"];
          }
        }

}else if(!globals.flag){
  for (var i = 0; i < address.length; i++) {
           if (address[i]['types'][0] == 'postal_code') {
            globals.newPostalCode = address[i]["long_name"];
          } else if (address[i]['types'][0] == 'country') {
            globals.newCountryIso = address[i]["short_name"];
            globals.newCountry = address[i]["long_name"];
          }else if (address[i]['types'][0] == 'locality') {
            globals.newCity = address[i]["long_name"];
          } else if (address[i]['types'][0] == 'route') {
            globals.newStreet = address[i]["short_name"];
          } else if (address[i]['types'][0] == 'street_number') {
            globals.newBuilding = address[i]["long_name"];
          }
        }
        
}

                
          print(globals.countryIso);
          print(globals.country);
          print(globals.postalCode);
          print(globals.city);
          print(globals.street);
          print(globals.building);
          print(globals.newStreet);
          print(globals.newBuilding);
          return true;
        }
      } else {
        print(data["error_message"]);
      }
    } else {
      print("error while fetching geoconding data");
    }
  }