import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart'; //for switch case usage
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/obj_details_counter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'c2_obj_location.dart';
import '../routes.dart';
import '../globals.dart' as globals;

// ignore_for_file: prefer_const_constructors

class ObjDetailsPage extends StatefulWidget {
  const ObjDetailsPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return ObjDetails();
  }
}

class ObjDetails extends State<ObjDetailsPage> {

  bool currentPositionOnMap = false;
  // Initial Selected Value
  String dropdownLevelValue = 'GROUND FLOOR';
  String dropdownUULIDValue = 'LOREM';

  @override
  void initState() {
    super.initState();
    currentPositionOnMap = false;
  }

  // List of items in our Level dropdown menu
  var items = [
    'GROUND FLOOR',
    '1st FLOOR',
    '2nd FLOOR',
    '3d FLOOR',
    '5th FLOOR',
    '6th FLOOR',
    '7th FLOOR',
    '8th FLOOR',
    '9th FLOOR',
    '10th FLOOR',
  ];

  // List of items in our UULID dropdown menu
  var itemsuulid = [
    'LOREM',
    'QUISQUAM EST',
    'DOLOREM',
    'NEQUE PORRO',
    'QUI',
  ];

  _getRequests() async {
    setState(() {
BlocProvider.of<CounterNav>(context)
                                .add(CounterDecrementEvent());
    });
  }



  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255,246,246,246),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 25, left: 30),
                      elevation: 0.0,
                      backgroundColor: Colors.white.withOpacity(0.05),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (counter == 0) {
                            Navigator.pop(context);
                          } else {
                            BlocProvider.of<CounterNav>(context)
                                .add(CounterDecrementEvent());
                          }
                        },
                      );
                    },
                    child: Text(globals.generalContentArray['back'].toString().toUpperCase(),
                    style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),),
                  ),
                  counter != 2
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 25, right: 30),
                            elevation: 0.0,
                            backgroundColor: Colors.white.withOpacity(0.05),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (counter == 0) {
                                  globals.level = dropdownLevelValue;
                                  currentPositionOnMap = true;
                                }
                                if (counter == 1) {
                                  globals.uulid = dropdownUULIDValue;
                                }
                                if (counter < 2) {
                                  BlocProvider.of<CounterNav>(context)
                                      .add(CounterIncrementEvent());
                                } else {
                                  return;
                                }
                              },
                            );
                          },
                          child: Text(globals.generalContentArray['next'].toString().toUpperCase(),
                          style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),),
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: Column(
                children: ConditionalSwitch.list<int>(
                  context: context,
                  valueBuilder: (BuildContext context) => int.parse('$counter'),
                  caseBuilders: {
                    0: (BuildContext context) => <Widget>[
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child:Padding(
                                padding: EdgeInsets.only(top: 10,),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                    child: Align(
                                      heightFactor: 1,
                                      widthFactor: 1,
                                      child: ObjLocation(
                                          currentPositionOnMap:
                                              currentPositionOnMap),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<CounterNav>(context)
                                .add(CounterIncrementEvent());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ObjLocation(
                                                    currentPositionOnMap:
                                                        currentPositionOnMap,
                                                  ))).then(
                                         (val) => val ? _getRequests() : null);
                                    },
                                    child: Align(
                                      heightFactor: 0.8,
                                      widthFactor: 0.8,
                                      child: Container(),
                                    ),
                                  ),
                                ],
                              ),),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 290,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 290,
                                    height: 16,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        globals.generalContentArray['objDetailsPageText_1']
                          .toString()
                          .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(
                                                255, 124,160,209),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 290,
                                    height: 42,
                                    child: SizedBox(
                                      child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        globals.flag?"${globals.street} ${globals.building}":"${globals.newStreet} ${globals.newBuilding}",
                                        overflow:TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 15,77,154),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    ),
                                  ),
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
                                        globals.generalContentArray['objDetailsPageText_2']
                          .toString()
                          .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(
                                                255, 124,160,209),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 290,
                                    height: 50,
                                    child: DropdownButton(
                                      menuMaxHeight: 200,
                                      isExpanded: true,
                                      // Initial Value
                                      value: dropdownLevelValue,
                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color.fromARGB(
                                              255, 246, 246, 247)),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(
                                                255, 15,77,154),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),

                                      dropdownColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      underline: Container(
                                        height: 2,
                                        color: Color.fromARGB(
                                                255, 124,160,209), //<-- SEE HERE
                                      ),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownLevelValue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        ],
                    1: (BuildContext context) => <Widget>[
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/img/Logo_house.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'UULID',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Color.fromARGB(255, 15,77,154),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 290,
                                  height: 50,
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(30),
                                    menuMaxHeight: 170,
                                    isExpanded: true,
                                    // Initial Value
                                    value: dropdownUULIDValue,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color:
                                            Color.fromARGB(255, 124,160,209),),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 124,160,209),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    dropdownColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    underline: Container(
                                      height: 2,
                                      color: Color.fromARGB(255, 124,160,209), 
                                    ),

                                    // Array list of items
                                    items: itemsuulid.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownUULIDValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 0,
                                  height: 0,
                                  child: DropdownButton2(
                                    isExpanded: true,

                                    //menuMaxHeight: 200,
                                    items: itemsuulid
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  color: Color.fromARGB(255, 124,160,209),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownUULIDValue,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownUULIDValue = value as String;
                                      });
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color:
                                            Color.fromARGB(255, 15,77,154),),
                                    buttonPadding:
                                        const EdgeInsets.only(left: 15),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(255, 76, 78, 82),
                                    ),
                                    buttonHeight: 40,
                                    buttonWidth: 290,
                                    itemHeight: 40,
                                    dropdownMaxHeight: 170,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                    2: (BuildContext context) => <Widget>[
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/img/Logo_house.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(300, 200),
                                  backgroundColor:
                                      Color.fromARGB(255, 212,223,236),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 4,
                                  shadowColor:
                                      Color.fromARGB(255, 250, 250, 250),
                                  ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.photoPage);
                                },
                                child: Text(
                                  globals.generalContentArray['objDetailsPageText_4']
                          .toString()
                          .toUpperCase(),
                                  style: TextStyle(
                      color: Color.fromARGB(255, 15,77,154),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                  },
                  fallbackBuilder: (BuildContext context) => <Widget>[
                    Text('Widget XX'),
                    Text('Widget XX'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.black.withOpacity(0.0),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.circle,
                        color: (counter == 0)
                            ? Color.fromARGB(255, 15,77,154)
                            : Color.fromARGB(255, 124,160,209),
                        size: 22),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.black.withOpacity(0.0),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.circle,
                        color: (counter == 1)
                            ? Color.fromARGB(255, 15,77,154)
                            : Color.fromARGB(255, 124,160,209),
                        size: 22),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.black.withOpacity(0.0),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.circle,
                        color: (counter == 2)
                            ? Color.fromARGB(255, 15,77,154)
                            : Color.fromARGB(255, 124,160,209),
                        size: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
