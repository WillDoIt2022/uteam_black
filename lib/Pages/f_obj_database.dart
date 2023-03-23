import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:text_tools/text_tools.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; //Spinner
import 'package:dropdown_button2/dropdown_button2.dart'; //DropDawn buttons
import '../Widgets/footer_menu.dart';
import '../routes.dart';
import '../globals.dart' as globals;

// ignore_for_file: prefer_const_constructors

class DataBasePage extends StatefulWidget {
  const DataBasePage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _DataBase();
  }
}

class _DataBase extends State<DataBasePage> {
  final docObjects = FirebaseFirestore.instance.collection('objects');
  final controllerSearch = TextEditingController(text: "");
  final List<String> itemsToFilter = [
    'All',
    'UULID',
    'location',
  ];
  String? selectedFilteredValue = "All";

  List filteredDb = [];
  List sourceDb = [];
  bool filteredDbflag = false;
  dynamic data;
  @override
  void initState() {
    super.initState();
    getUserObjects();
  }

  Future getUserObjects() async {
    await docObjects
        .where("phoneNumber", isEqualTo: globals.phoneNumber.toString())
        .get()
        .then((QuerySnapshot snapshot) {
      filteredDb = snapshot.docs.toList();
      sourceDb = snapshot.docs;
      setState(() {
        filteredDbflag = true;
      });
    });
  }

  objectDetailsSet(data) {
    globals.flag = false;
    globals.objectId = data['id'];
    globals.newLatitude = data['latitude'];
    globals.newLongitude = data['longitude'];
    globals.uulid = data['uulid'];
    globals.newCountry = data['country'];
    globals.newCountryIso = data['countryIso'];
    globals.newPostalCode = data['postalCode'];
    globals.newStreet = data['street'];
    globals.newBuilding = data['building'];
    globals.level = data['level'];
    globals.imgUrl = data['imgUrl'];
  }

  filterDbFunctionFunction() {
    filteredDb = sourceDb;
    if (selectedFilteredValue.toString().toLowerCase() == "all") {
      setState(() {
        filteredDb = filteredDb
            .where((e) => (e["uulid"]
                    .contains(controllerSearch.text.toString().toLowerCase()) ||
                e["street"]
                    .contains(controllerSearch.text.toString().toLowerCase()) ||
                e["building"]
                    .contains(controllerSearch.text.toString().toLowerCase())))
            .toList();
      });
    } else if (selectedFilteredValue.toString().toLowerCase() == "location") {
      setState(() {
        filteredDb = filteredDb
            .where((e) => (e["street"]
                    .contains(controllerSearch.text.toString().toLowerCase()) ||
                e["building"]
                    .contains(controllerSearch.text.toString().toLowerCase())))
            .toList();
      });
    } else {
      setState(() {
        filteredDb = filteredDb
            .where((e) => (e[selectedFilteredValue.toString().toLowerCase()]
                .contains(controllerSearch.text.toString().toLowerCase())))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: filteredDbflag
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Text(
                        "FILTER APPLIED: ${selectedFilteredValue.toString().toUpperCase()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 124, 160, 209),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 124, 160, 209),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 246, 246, 246),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                        controller: controllerSearch,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          labelText: 'SEARCH',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 246, 246, 246)),
                          prefixIcon: ImageIcon(
                            AssetImage("assets/img/Search.png"),
                            color: Color.fromARGB(255, 246, 246, 246),
                            size: 25,
                          ),
                          suffixIcon: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              isDense: true,
                              customButton: ImageIcon(
                                AssetImage("assets/img/Search_Indicator.png"),
                                color: Color.fromARGB(255, 246, 246, 246),
                                size: 25,
                              ),
                              items: itemsToFilter
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item.toUpperCase(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 124, 160, 209),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedFilteredValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedFilteredValue = newValue;
                                  controllerSearch.text="";
                                  filteredDb = sourceDb;
                                });
                              },
                              dropdownWidth:
                                  MediaQuery.of(context).size.width * 0.4,
                              dropdownMaxHeight: 200,
                              offset: Offset(-160, 0),
                              itemHeight: 40,
                            ),
                          ),
                          hintText: '',
                        ),
                        onChanged: (value) {
                          controllerSearch.value = TextEditingValue(
                              text: value.toUpperCase(),
                              selection: controllerSearch.selection);
                          filterDbFunctionFunction();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 11,
                child: filteredDb.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredDb.length,
                        itemBuilder: (BuildContext context, index) {
                          return ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(20),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  height: 150,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 222, 229, 239),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 00),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: Text(
                                                            'object name'
                                                                .toUpperCase(),
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      124,
                                                                      160,
                                                                      209),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: Text(
                                                            'uulid'
                                                                .toUpperCase(),
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      124,
                                                                      160,
                                                                      209),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: Text(
                                                            'location'
                                                                .toUpperCase(),
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      124,
                                                                      160,
                                                                      209),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 15,
                                                            ),
                                                            child: Text(
                                                              TextTools
                                                                  .toUppercaseFirstLetter(
                                                                      text:
                                                                          'some name'),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        124,
                                                                        160,
                                                                        209),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 15,
                                                            ),
                                                            child: Text(
                                                              TextTools.toUppercaseFirstLetter(
                                                                  text: filteredDb[
                                                                          index]
                                                                      [
                                                                      "uulid"]),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        124,
                                                                        160,
                                                                        209),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 15,
                                                            ),
                                                            child: Text(
                                                              TextTools
                                                                  .toUppercaseFirstLetter(
                                                                      text:
                                                                          "${filteredDb[index]['street']}, ${filteredDb[index]['building']}"),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        124,
                                                                        160,
                                                                        209),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ])
                                                ])),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    data = filteredDb[index];
                                                    objectDetailsSet(data);
                                                    globals.onSave = false;
                                                    Navigator.pushNamed(
                                                      context,
                                                      Routes.objectPage,
                                                    );
                                                  },
                                                  child: Text(
                                                    'view more'.toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 15, 77, 154),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                    : SizedBox(
                        child: Center(
                          child: Text(
                            "No matches found",
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
              Expanded(
                flex: 2,
                child: FooterMenu(),
              ),
            ])
          : Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: Color.fromARGB(255, 15, 77, 154),
                size: 50,
              ),
            ),
    );
  }
}
