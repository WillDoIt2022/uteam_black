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
  String dropdownLevelValue =
      globals.level == "" ? 'ground floor' : globals.level;
  String dropdownUULIDValue = globals.uulid == "" ? 'lorem' : globals.uulid;

  @override
  void initState() {
    super.initState();
    currentPositionOnMap = false;
  }

  // List of items in our Level dropdown menu
  var itemsFloor = [
    'ground floor',
    '1st floor',
    '2nd floor',
    '3d floor',
    '5th floor',
    '6th floor',
    '7th floor',
    '8th floor',
    '9th floor',
    '10th floor',
  ];

  // List of items in our UULID dropdown menu
  var itemsuulid = [
    'lorem',
    'quisquam est',
    'dolorem',
    'neque porro',
    'qui',
  ];

  _goToGooleMapPage(toShowAddress, onEditAdress) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjLocation(
                    currentPositionOnMap: currentPositionOnMap,
                    toShowAddress: toShowAddress,
                    onEditAdress: onEditAdress)))
        .then((val) => val ? _toUpdateWidget() : null);
  }

  _toUpdateWidget() async {
    setState(() {
      BlocProvider.of<CounterNav>(context).add(CounterResetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
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
                      print(counter);
                      setState(
                        () {
                          if (globals.objectId == "") {
                            if (counter == 0) {
                              Navigator.pop(context);
                            } else {
                              BlocProvider.of<CounterNav>(context)
                                  .add(CounterDecrementEvent());
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      );
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
                  counter != 2 && globals.objectId == ""
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 25, right: 30),
                            elevation: 0.0,
                            backgroundColor: Colors.white.withOpacity(0.05),
                          ),
                          onPressed: () {
                            print(counter);
                            setState(
                              () {
                                if (counter == 0) {
                                  currentPositionOnMap = true;
                                  globals.level = dropdownLevelValue;
                                }
                                if (counter == 1) {
                                  //if adding a new object
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
                          child: Text(
                            globals.generalContentArray['next']
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
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
                                                currentPositionOnMap,
                                            toShowAddress: false,
                                            onEditAdress: false),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<CounterNav>(context)
                                            .add(CounterIncrementEvent());
                                        _goToGooleMapPage(true, false);
                                      },
                                      child: Align(
                                        heightFactor: 0.8,
                                        widthFactor: 0.8,
                                        child: Container(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                        globals.generalContentArray[
                                                'objDetailsPageText_1']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 124, 160, 209),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 290,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 2.0,
                                          color: Color.fromARGB(
                                              255, 124, 160, 209),
                                        ),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<CounterNav>(context)
                                            .add(CounterDecrementEvent());
                                        _goToGooleMapPage(false, true);
                                      },
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              globals.flag
                                                  ? "${globals.street}, ${globals.building}"
                                                  : "${globals.newStreet}, ${globals.newBuilding}",
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
                                        globals.generalContentArray[
                                                'objDetailsPageText_2']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 124, 160, 209),
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
                                  SizedBox(
                                    width: 290,
                                    height: 30,
                                    child: DropdownButton2(
                                      buttonWidth: 290,
                                      buttonPadding:
                                          const EdgeInsets.only(left: 15),
                                      isExpanded: true,
                                      isDense: true,
                                      // Initial Value
                                      underline: Container(
                                        height: 2,
                                        color:
                                            Color.fromARGB(255, 124, 160, 209),
                                      ),
                                      value: dropdownLevelValue,

                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 15, 77, 154),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color:
                                              Color.fromARGB(255, 15, 77, 154)),

                                      dropdownMaxHeight: 200,
                                      dropdownDecoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(30),
                                        color:
                                            Color.fromARGB(255, 222, 229, 239),
                                      ),
                                      // Array list of items
                                      items: itemsFloor.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items.toUpperCase()),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownLevelValue = newValue!;
                                          globals.level = newValue;
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
                                  color: Color.fromARGB(255, 15, 77, 154),
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
                                  height: 30,
                                  child: DropdownButton2(
                                    buttonWidth: 290,
                                    isExpanded: true,
                                    isDense: true,
                                    underline: Container(
                                      height: 2,
                                      color: Color.fromARGB(255, 124, 160, 209),
                                    ),
                                    value: dropdownUULIDValue,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 124, 160, 209),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    //menuMaxHeight: 200,
                                    items: itemsuulid.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.toUpperCase()),
                                      );
                                    }).toList(),

                                    onChanged: (value) {
                                      setState(() {
                                        dropdownUULIDValue = value as String;
                                        globals.uulid = value;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromARGB(255, 15, 77, 154),
                                    ),
                                    buttonPadding:
                                        const EdgeInsets.only(left: 15),
                                    dropdownDecoration: BoxDecoration(
                                      //borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(255, 222, 229, 239),
                                    ),

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
                                      Color.fromARGB(255, 212, 223, 236),
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
                                  globals.generalContentArray[
                                          'objDetailsPageText_4']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 15, 77, 154),
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
              child: globals.objectId == ""
                  ? Row(
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
                                  ? Color.fromARGB(255, 15, 77, 154)
                                  : Color.fromARGB(255, 124, 160, 209),
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
                                  ? Color.fromARGB(255, 15, 77, 154)
                                  : Color.fromARGB(255, 124, 160, 209),
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
                                  ? Color.fromARGB(255, 15, 77, 154)
                                  : Color.fromARGB(255, 124, 160, 209),
                              size: 22),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      );
    });
  }
}
