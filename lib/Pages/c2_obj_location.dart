import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/obj_details_counter.dart';
import '../globals.dart' as globals;
import '../Widgets/geocoding.dart';

class ObjLocation extends StatefulWidget {
  const ObjLocation({Key? key, required this.currentPositionOnMap})
      : super(key: key);
  final bool currentPositionOnMap;
  @override
  ObjLocationState createState() => ObjLocationState();
}

class ObjLocationState extends State<ObjLocation> {
  dynamic street = globals.flag ? globals.street : globals.newStreet;
  dynamic building = globals.flag ? globals.building : globals.newBuilding;
  LatLng location = LatLng(48.8583701, 2.2944813);
  LatLng currentLocation = LatLng(globals.latitude, globals.longitude);
  LatLng newLocation = LatLng(globals.newLatitude, globals.newLongitude);
  @override
  void initState() {
    super.initState();

    //Do not rerender the map with current position, if it is already done
    if (widget.currentPositionOnMap == false) {
      updateCameraLocation(currentLocation);
    } else {
      return;
    }
  }

  Future updateCameraLocation(location) async {
    final GoogleMapController controller = await globals.mapController.future;
    final CameraPosition newCameraPosition =
        CameraPosition(target: location, zoom: 16);
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return WillPopScope(
          onWillPop: () async {
            //Using to update googleMap view on preview on Native Back.
            BlocProvider.of<CounterNav>(context).add(CounterDecrementEvent());
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  // in the below line, creating google maps.
                  child: GoogleMap(
                    // in the below line, setting camera position
                    initialCameraPosition: CameraPosition(
                      target: globals.flag ? currentLocation : newLocation,
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
                        position: globals.flag ? currentLocation : newLocation,
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
                        globals.mapController.complete(controller);
                      } else {
                        return;
                      }
                    },
                  ),
                ),
                counter != 0
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          elevation: 0.0,
                          backgroundColor: Colors.white.withOpacity(0.05),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          globals.generalContentArray['back'].toString().toUpperCase(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Container(),
                counter != 0
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15), //apply padding to all four sides
                                child: Text(
                                  textAlign: TextAlign.left,
                                  '$street $building',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 246, 246, 246),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ));
    });
  }
}
