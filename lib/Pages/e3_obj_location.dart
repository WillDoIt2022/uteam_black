import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'
    show rootBundle; //to get Google Map custom styles
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../BLoC/obj_details_counter.dart';
import '../globals.dart' as globals;
import '../Widgets/geocoding.dart';
import 'dart:math';
//import "../routes.dart";

class ObjLocation extends StatefulWidget {
  const ObjLocation(
      {Key? key,
      required this.currentPositionOnMap,
      required this.toShowAddress,
      required this.onEditAdress,
      required this.immovable})
      : super(key: key);
  final bool currentPositionOnMap;
  final bool toShowAddress;
  final bool onEditAdress;
  final bool immovable;
  @override
  ObjLocationState createState() => ObjLocationState();
}

class ObjLocationState extends State<ObjLocation> {
  //to show Container with choosen address or now
  bool toShowAddress = false;
  //if User wants to search object by address or no
  bool onEditAdress = false;
  //What street to show
  dynamic street = globals.flag ? globals.street : globals.newStreet;
  //What building to show to show
  dynamic building = globals.flag ? globals.building : globals.newBuilding;
//holds calculatef distance of iterable List of exist object
  num? distance;
  //holds nearest object Lat & Long
  double nearestObjectLatitude = 0.0;
  double nearestObjectLongitude = 0.0;
  dynamic prevNearestObjectDistance = 0;

  //LatLng location = LatLng(48.8583701, 2.2944813);
  //auto detected user location
  LatLng currentLocation = LatLng(globals.latitude, globals.longitude);
  //new location, which was choosen by User
  LatLng newLocation = LatLng(globals.newLatitude, globals.newLongitude);
  //settings of customized map
  String? _mapStyle;
  //here we keep current mapController, to move map
  dynamic currentMapController;
  //here we keep dropdown list of address suggestions
  String searchLocation = "Search Location";

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    //connecting customize Google map setting
    rootBundle.loadString('assets/style/map_style.txt').then((string) {
      _mapStyle = string;
    }).catchError((error) {
      print(error.toString());
    });
    toShowAddress = widget.toShowAddress;
    onEditAdress = widget.onEditAdress;
    //To build searchBar box for searching object by address, after widhet built
    onEditAdress
        ? WidgetsBinding.instance
            .addPostFrameCallback((_) => openSearchBarByAddress())
        : null;
    showAllObjects();
    setState(() {});
    //Do not rerender the map with current position if position already choosen
    if (widget.currentPositionOnMap == false && widget.immovable == true) {
      updateCameraLocation(currentLocation);
    } else {
      return;
    }
  }

  openSearchBarByAddress() async {
    var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: dotenv.env['GOOGLE_APIKEY']!,
        mode: Mode.overlay,
        logo: Text(""), //to hide Google logo
        language: globals.countryIso,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, globals.countryIso)],
        //google_map_webservice package
        onError: (err) {
          print(err);
        });

    if (place != null) {
      setState(() {
        searchLocation = place.description.toString();
      });
    }
    //form google_maps_webservice package
    final plist = GoogleMapsPlaces(
      apiKey: dotenv.env['GOOGLE_APIKEY'],
      apiHeaders: await GoogleApiHeaders().getHeaders(),
      //from google_api_headers package
    );
    String placeid = place?.placeId ?? "0";
    final detail = await plist.getDetailsByPlaceId(placeid);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lang = geometry.location.lng;
    var newlatlang = LatLng(lat, lang);
    print(newlatlang);

    globals.latitude = geometry.location.lat;
    globals.longitude = geometry.location.lng;
    globals.flag = true;
    convertToAddress().then((value) {
      setState(() {
        street = globals.street;
        building = globals.building;
        currentLocation = LatLng(globals.latitude, globals.longitude);
      });
    });
    updateDB();
    CameraPosition newCameraPosition =
        CameraPosition(target: newlatlang, zoom: 18);
    currentMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future updateCameraLocation(location) async {
    GoogleMapController controller = await globals.mapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: location, zoom: 18);

    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  showAllObjects() {
    for (var i = 0; i < globals.existAddressesInAccount.length; i++) {
      Marker existAddress = Marker(
        markerId: MarkerId(globals.existAddressesInAccount[i]["id"]),
        position: LatLng(globals.existAddressesInAccount[i]["latitude"],
            globals.existAddressesInAccount[i]["longitude"]),
        infoWindow: InfoWindow(
            title: globals.existAddressesInAccount[i]["country"],
            snippet: globals.existAddressesInAccount[i]["street"] +
                globals.existAddressesInAccount[i]["building"]),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          newLocation = LatLng(globals.existAddressesInAccount[i]["latitude"],
              globals.existAddressesInAccount[i]["longitude"]);
          globals.flag = false;
          globals.newLatitude = globals.existAddressesInAccount[i]["latitude"];
          globals.newLongitude =
              globals.existAddressesInAccount[i]["longitude"];
          convertToAddress().then((value) {
            street = globals.newStreet;
            building = globals.newBuilding;
            setState(() {});
          });
        },
      );
      markers.add(existAddress);
    }
    print("markers length start");
    print(markers.length);

    if (globals.lastSelectedAddress == null) {
      if (widget.immovable == false) {
        Marker existAddress = Marker(
          markerId: MarkerId("123"),
          position: LatLng(globals.newLatitude, globals.newLongitude),
          infoWindow: InfoWindow(title: "nearest object", snippet: ""),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            newLocation = LatLng(globals.newLatitude, globals.newLongitude);
            globals.flag = false;
          },
        );
        markers.add(existAddress);
      }
      if (widget.immovable == true) {
        Marker currentAddress = Marker(
          markerId: MarkerId("123"),
          position: LatLng(globals.latitude, globals.longitude),
          infoWindow: InfoWindow(title: "current position", snippet: ""),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {},
        );
        markers.add(currentAddress);
      }
    } else {
      if (widget.immovable == true) {
        markers.add(globals.lastSelectedAddress!);
      }
    }
    print("markers length end");
    print(markers.length);

    setState(() {});
  }

  updateDB() {
    Marker newAddress = Marker(
      markerId: MarkerId("123"),
      position: LatLng(globals.latitude, globals.longitude),
      infoWindow: InfoWindow(
          title: globals.country, snippet: globals.street + globals.building),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () {
        newLocation = LatLng(globals.latitude, globals.longitude);
        globals.flag = true;
      },
    );
    globals.lastSelectedAddress = newAddress;
    markers.remove(markers.last);
    markers.add(newAddress);

    setState(() {});
    print(markers.length);
    print(markers);
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
            //This is a default behavior
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
                          initialCameraPosition: globals.flag
                              ? CameraPosition(
                                  target: currentLocation,
                                  zoom: 19,
                                )
                              : CameraPosition(
                                  target: newLocation,
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
                            if (widget.immovable == true) {
                              newLocation = latLng;
                              //globals.flag = false;
                              globals.latitude = latLng.latitude;
                              globals.longitude = latLng.longitude;
                              convertToAddress().then((value) {
                                street = globals.street;
                                building = globals.building;
                                updateDB();
                                setState(() {});
                              });
                            } else {
                              return;
                            }
                          },
                          markers: markers.map((e) => e).toSet(),

                          //{

                          //Marker(
                          //markerId: const MarkerId("marker1"),
                          //position:currentLocation,
                          //globals.flag ? currentLocation : newLocation,
                          // draggable: true,
                          //onDragEnd: (value) {
                          //  currentLocation = value;
                          //value is the new position
                          //  globals.newLatitude = value.latitude;
                          //  globals.newLongitude = value.longitude;
                          //  globals.flag = false;
                          //  convertToAddress().then((value) {
                          //  street = globals.newStreet;
                          //   building = globals.newBuilding;
                          //   setState(() {});
                          //  });
                          // }
                          //),
                          //},
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
                                    if (widget.immovable == true) {
                                      setState(() {
                                        toShowAddress = false;
                                        onEditAdress = true;
                                      });
                                      openSearchBarByAddress();
                                    } else {
                                      return;
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          child: Text(
                                            '$street $building',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      )
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
                              InkWell(
                                onTap: () {
                                  openSearchBarByAddress();
                                },
                                child: Container(
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
                                  child: SizedBox(
                                    child: Text(
                                      '$street $building',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 15, 77, 154),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      )
                    : Container(),
              ]),
        ),
      );
    });
  }
}
