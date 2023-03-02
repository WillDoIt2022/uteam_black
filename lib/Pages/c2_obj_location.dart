import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'
    show rootBundle; //to get Google Map custom styles
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import '../BLoC/obj_details_counter.dart';
import '../globals.dart' as globals;
import '../Widgets/geocoding.dart';
//import "../routes.dart";

class ObjLocation extends StatefulWidget {
  const ObjLocation(
      {Key? key,
      required this.currentPositionOnMap,
      required this.toShowAddress,
      required this.onEditAdress})
      : super(key: key);
  final bool currentPositionOnMap;
  final bool toShowAddress;
  final bool onEditAdress;
  @override
  ObjLocationState createState() => ObjLocationState();
}

class ObjLocationState extends State<ObjLocation> {
  //Completer<GoogleMapController> mapController = Completer();
  //GoogleMapController? controller;
  bool toShowAddress = false;
  bool onEditAdress = false;
  dynamic street = globals.flag ? globals.street : globals.newStreet;
  dynamic building = globals.flag ? globals.building : globals.newBuilding;
  LatLng location = LatLng(48.8583701, 2.2944813);
  LatLng currentLocation = LatLng(globals.latitude, globals.longitude);
  LatLng newLocation = LatLng(globals.newLatitude, globals.newLongitude);
  String? _mapStyle;

  dynamic currentMapController;

  String searchLocation = "Search Location";

  dynamic controllerSearchAddress = TextEditingController(text: "");
  // List of items in our Level dropdown menu
  List<Map<String, dynamic>> addressItems = [
    {"id": 1, "street": "Puskinskaya", "building": 5},
    {"id": 2, "street": "Derebasovskaya", "building": 6},
    {"id": 3, "street": "Khreshatik", "building": 9},
    {"id": 4, "street": "Saksaganskogo", "building": 23},
    {"id": 5, "street": "Kablukova", "building": 18},
  ];

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/style/map_style.txt').then((string) {
      _mapStyle = string;
    }).catchError((error) {
      print(error.toString());
    });
    toShowAddress = widget.toShowAddress;
    onEditAdress = widget.onEditAdress;
    controllerSearchAddress = TextEditingController(text: "$street, $building");
    setState(() {});
    //Do not rerender the map with current position, if it is already done
    if (widget.currentPositionOnMap == false) {
      updateCameraLocation(currentLocation);
    } else {
      return;
    }
  }

  Future updateCameraLocation(location) async {
    GoogleMapController controller = await globals.mapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: location, zoom: 18);

    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return WillPopScope(
        onWillPop: () async {
          //if counter ==-1, that means, that User came here to search by adress. In this case, on Back will push obj_details page and will add 1point to counter
          if (counter == -1) {
            BlocProvider.of<CounterNav>(context).add(CounterIncrementEvent());
            //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('counter = -1')));
            return true;
          } else if (counter == 1) {
            //if counter ==1, that means, that User came here to search by map. In this case, on Back will push obj_details page and will minus 1point from the counter.
            //if back clicked on search by address page, will go back to the map at first
            if (toShowAddress == true) {
              BlocProvider.of<CounterNav>(context).add(CounterDecrementEvent());
              return true;
            } else {
              setState(() {
                toShowAddress = true;
                onEditAdress = false;
              });
              return false;
            }
          } else {
            //This ыуе a default behavior
            return false;
          }
        },
        child: Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Stack(
                    children: [
                      SizedBox(
                        // in the below line, creating google maps.
                        child: GoogleMap(
                          // in the below line, setting camera position
                          initialCameraPosition: CameraPosition(
                            target:
                                globals.flag ? currentLocation : newLocation,
                            zoom: 19,
                          ),
                          // in the below line, specifying map type.
                          mapType: MapType.normal,
                          // in the below line, setting user location enabled.
                          myLocationEnabled: true,
                          // in the below line, setting compass enabled.
                          compassEnabled: true,
                          // in the below line, specifying controller on map complete.
                          onTap: (LatLng latLng) {
                            newLocation = latLng;
                            globals.flag = false;
                            globals.newLatitude = latLng.latitude;
                            globals.newLongitude = latLng.longitude;
                            convertToAddress().then((value) {
                              street = globals.newStreet;
                              building = globals.newBuilding;
                              setState(() {});
                            });
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId("marker1"),
                              position:
                                  globals.flag ? currentLocation : newLocation,
                              draggable: true,
                              onDragEnd: (value) {
                                currentLocation = value;
                                // value is the new position
                                globals.newLatitude = value.latitude;
                                globals.newLongitude = value.longitude;
                                globals.flag = false;
                                convertToAddress().then((value) {
                                  street = globals.newStreet;
                                  building = globals.newBuilding;
                                  setState(() {});
                                });
                              },
                            ),
                          },
                          onMapCreated: (GoogleMapController controller) {
                            if (!globals.mapController.isCompleted) {
                              controller.setMapStyle(_mapStyle);
                              globals.mapController.complete(controller);
                              currentMapController = controller;
                            } else {
                              controller.setMapStyle(_mapStyle);
                              currentMapController = controller;
                            }
                          },
                        ),
                      ),
                      counter != 0
                          ? Padding(
                              padding: EdgeInsets.only(top: 25, left: 30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 250, 250, 250),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                  counter == -1
                                      ? Navigator.pop(context, true)
                                      : toShowAddress
                                          ? Navigator.pop(context, true)
                                          : setState(() {
                                              toShowAddress = true;
                                              onEditAdress = false;
                                            });
                                },
                                child: Text(
                                  globals.generalContentArray['back']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      toShowAddress
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 40,
                                width: 320,
                                margin: const EdgeInsets.only(bottom: 100.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 124, 160, 209),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      toShowAddress = false;
                                      onEditAdress = true;
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          '$street $building',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 246, 246, 246),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                onEditAdress
                    ? Expanded(
                        flex: 7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 290,
                                height: 14,
                              ),
                              SizedBox(
                                width: 290,
                                height: 16,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    globals.generalContentArray[
                                            'objDetailsPageText_2']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 124, 160, 209),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 290,
                                height: 10,
                              ),
                              Container(
                                  width: 290,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromARGB(255, 15, 77, 154)),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      var place = await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: globals.googleApikey,
                                          mode: Mode.overlay,
                                          types: [],
                                          strictbounds: false,
                                          components: [
                                            Component(Component.country,
                                                globals.countryIso)
                                          ],
                                          //google_map_webservice package
                                          onError: (err) {
                                            print(err);
                                          });

                                      if (place != null) {
                                        setState(() {
                                          searchLocation =
                                              place.description.toString();
                                        });
                                      }
                                      //form google_maps_webservice package
                                      final plist = GoogleMapsPlaces(
                                        apiKey: globals.googleApikey,
                                        apiHeaders: await GoogleApiHeaders()
                                            .getHeaders(),
                                        //from google_api_headers package
                                      );
                                      String placeid = place?.placeId ?? "0";
                                      final detail = await plist
                                          .getDetailsByPlaceId(placeid);
                                      final geometry = detail.result.geometry!;
                                      final lat = geometry.location.lat;
                                      final lang = geometry.location.lng;
                                      var newlatlang = LatLng(lat, lang);
                                      print(newlatlang);

                                      globals.newLatitude =
                                          geometry.location.lat;
                                      globals.newLongitude =
                                          geometry.location.lng;
                                      globals.flag = false;
                                      convertToAddress().then((value) {
                                        setState(() {
                                          street = globals.newStreet;
                                          building = globals.newBuilding;
                                          newLocation = LatLng(
                                              globals.newLatitude,
                                              globals.newLongitude);
                                        });
                                      });
                                      CameraPosition newCameraPosition =
                                          CameraPosition(
                                              target: newlatlang, zoom: 18);
                                      currentMapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              newCameraPosition));
                                    },
                                    child: SizedBox(
                                      child: Text(
                                        '$street $building',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 15, 77, 154),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )),
                            ]),
                      )
                    : Container(),
              ]),
        ),
      );
    });
  }
}
