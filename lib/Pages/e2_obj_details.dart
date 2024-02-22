import 'package:flutter/material.dart';
//packages
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart'; //for switch case usage
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:text_tools/text_tools.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import 'package:loading_animation_widget/loading_animation_widget.dart'; //Spinner
import 'package:permission_handler/permission_handler.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
//widgets
import 'e3_obj_location.dart';
import '../Widgets/uulid_api.dart'; //fetch uulid DB
//settings
import '../routes.dart';
import '../globals.dart' as globals;
import '../BLoC/obj_details_counter.dart';
// ignore_for_file: prefer_const_constructors
// ignore: import_of_legacy_library_into_null_safe

class ObjDetailsPage extends StatefulWidget {
  const ObjDetailsPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return ObjDetails();
  }
}

class ObjDetails extends State<ObjDetailsPage> with WidgetsBindingObserver {
  bool immovable = globals.immovable;
  bool currentPositionOnMap = false;
  bool cameraPermissionStatus = false;
  bool uulidSelected = false;
  bool uulidAPIRequestFlag = false;
  TextEditingController controllerBrand = globals.brandName == ""
      ? TextEditingController()
      : TextEditingController(text: globals.brandName);
  TextEditingController controllerCommercialName = globals.commercialName == ""
      ? TextEditingController()
      : TextEditingController(text: globals.commercialName);
  TextEditingController controllerSerialNumber = globals.serialNumber == ""
      ? TextEditingController()
      : TextEditingController(text: globals.serialNumber);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Initial Selected Value
  String dropdownLevelValue =
      globals.level == "" ? 'ground floor' : globals.level;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    currentPositionOnMap = false;
    checkCameraPermissions();
    print(globals.uulidDB);
    globals.dropdownUULIDValueLevel0 = null;

    uulidLabelsExistChecker();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  checkCameraPermissions() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is denined.");
    } else if (status.isGranted) {
      //permission is already granted.
      print("Permission is already granted.");
      setState(() {
        cameraPermissionStatus = false;
      });
    } else if (status.isPermanentlyDenied) {
      //permission is permanently denied.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is permanently denied");
    } else if (status.isRestricted) {
      //permission is OS restricted.
      setState(() {
        cameraPermissionStatus = true;
      });
      print("Permission is OS restricted.");
    }
  }

  uulidLabelsExistChecker() {
    if (globals.fullPath.isNotEmpty) {
      List<String> strarray = globals.fullPath.split(".");
      print("For test Im here??");
      globals.dropdownUULIDValueLevel0 = strarray.length >= 1
          ? globals.uulidDB[0][(0).toString()][int.parse(strarray[0]) - 1]
          : null;
      globals.dropdownUULIDValueLevel1 = strarray.length >= 2
          ? globals.uulidDB[1][(1).toString()][int.parse(strarray[1]) - 1]
          : null;
      globals.dropdownUULIDValueLevel2 = strarray.length >= 3
          ? globals.uulidDB[2][(2).toString()][int.parse(strarray[2]) - 1]
          : null;
      globals.dropdownUULIDValueLevel3 = strarray.length >= 4
          ? globals.uulidDB[3][(3).toString()][int.parse(strarray[3]) - 1]
          : null;
      globals.dropdownUULIDValueLevel4 = strarray.length >= 5
          ? globals.uulidDB[4][(4).toString()][int.parse(strarray[4]) - 1]
          : null;
      globals.dropdownUULIDValueLevel5 = strarray.length >= 6
          ? globals.uulidDB[5][(5).toString()][int.parse(strarray[5]) - 1]
          : null;
      globals.dropdownUULIDValueLevel6 = strarray.length >= 7
          ? globals.uulidDB[6][(6).toString()][int.parse(strarray[6]) - 1]
          : null;
      globals.dropdownUULIDValueLevel7 = strarray.length >= 8
          ? globals.uulidDB[7][(7).toString()][int.parse(strarray[7]) - 1]
          : null;
      globals.dropdownUULIDValueLevel8 = strarray.length >= 9
          ? globals.uulidDB[8][(8).toString()][int.parse(strarray[8]) - 1]
          : null;
      globals.dropdownUULIDValueLevel9 = strarray.length >= 10
          ? globals.uulidDB[9][(9).toString()][int.parse(strarray[9]) - 1]
          : null;
      //globals.dropdownUULIDValueLevel1 = globals.uulidDB[0][(0).toString()][i];
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkCameraPermissions();
    }
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

  _goToGooleMapPage(toShowAddress, onEditAdress) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjLocation(
                    currentPositionOnMap: currentPositionOnMap,
                    toShowAddress: toShowAddress,
                    onEditAdress: onEditAdress,
                    immovable: immovable)))
        .then((val) => val ? _toUpdateWidget() : null);
  }

  _toUpdateWidget() async {
    setState(() {
      BlocProvider.of<CounterNav>(context).add(CounterResetEvent());
    });
  }

  existAddressesInAccountIsEmpty() {
    uulidSelected = true;
    Flushbar(
      title: 'object uulid'.toUpperCase(),
      titleColor: Colors.red,
      titleSize: 18,
      message: 'There is no exist addresses in DB',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  noAdressNotification() {
    Flushbar(
      title: 'object'.toUpperCase(),
      titleColor: Colors.red,
      titleSize: 18,
      message: 'Building number should be set',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  lastUULIDLevelReached() {
    uulidSelected = true;
    Flushbar(
      title: 'object uulid'.toUpperCase(),
      titleColor: Colors.green,
      titleSize: 18,
      message: 'You have reached last UULID level',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  selectNextUULIDLevel() {
    uulidSelected = false;
    Flushbar(
      title: 'object uulid'.toUpperCase(),
      titleColor: Colors.yellow,
      titleSize: 18,
      message: 'Please, select next UULID',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  additionalInfo() {
    uulidSelected = false;
    Flushbar(
      title: 'additional object information'.toUpperCase(),
      titleColor: Colors.yellow,
      titleSize: 18,
      message: 'Please, complete all fields',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  noAPIResponse() {
    Flushbar(
      title: 'object uulid'.toUpperCase(),
      titleColor: Colors.yellow,
      titleSize: 18,
      message: 'Some problems with DB. Please, try again later',
      messageSize: 14,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
    return BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
          resizeToAvoidBottomInset:
              false, //when the keyboard appears, prevent the content resizing
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          body: Stack(children: [
            Column(
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
                          setState(() {
                            if (globals.objectId == "") {
                              if (counter == 0) {
                                Navigator.pop(context);
                              } else {
                                BlocProvider.of<CounterNav>(context)
                                    .add(CounterDecrementEvent());
                              }
                            } else {
                              print(uulidSelected);
                              if (counter == 1 && uulidSelected == false) {
                                selectNextUULIDLevel();
                              } else {
                                Navigator.pop(context);
                              }
                            }
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
                      counter != 3 && globals.objectId == ""
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
                                    if (counter == 1) {}
                                    if (counter == 2) {
                                      if (controllerBrand.text == "" ||
                                          controllerCommercialName.text == "" ||
                                          controllerSerialNumber.text == "") {
                                        additionalInfo();
                                        return;
                                      } 
                                    }
                                    if (counter < 3) {
                                      if (uulidSelected == false &&
                                          counter == 1) {
                                        print("Im making a request on click");
                                        selectNextUULIDLevel();
                                      } else {
                                        BlocProvider.of<CounterNav>(context)
                                            .add(CounterIncrementEvent());
                                      }
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: ConditionalSwitch.list<int>(
                        context: context,
                        valueBuilder: (BuildContext context) =>
                            int.parse('$counter'),
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
                                                  onEditAdress: false,
                                                  immovable: immovable),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<CounterNav>(
                                                      context)
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
                                              if (immovable == true) {
                                                BlocProvider.of<CounterNav>(
                                                        context)
                                                    .add(
                                                        CounterDecrementEvent());
                                                _goToGooleMapPage(false, true);
                                              } else {
                                                return;
                                              }
                                            },
                                            child: SizedBox(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    globals.flag
                                                        ? "${globals.street}, ${globals.building}"
                                                        : "${globals.newStreet}, ${globals.newBuilding}",
                                                    //TextTools
                                                    //.toUppercaseFirstLetter(
                                                    //text:
                                                    //"${globals.newStreet}, ${globals.newBuilding}"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 15, 77, 154),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                              color: Color.fromARGB(
                                                  255, 124, 160, 209),
                                            ),
                                            value: dropdownLevelValue,

                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            // Down Arrow Icon
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color.fromARGB(
                                                    255, 15, 77, 154)),

                                            dropdownMaxHeight: 200,
                                            dropdownDecoration: BoxDecoration(
                                              //borderRadius: BorderRadius.circular(30),
                                              color: Color.fromARGB(
                                                  255, 222, 229, 239),
                                            ),
                                            // Array list of items
                                            items:
                                                itemsFloor.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child:
                                                    Text(items.toUpperCase()),
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
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height:
                                                    MediaQueryData.fromWindow(
                                                                WidgetsBinding
                                                                    .instance
                                                                    .window)
                                                            .size
                                                            .width *
                                                        0.1,
                                                width:
                                                    MediaQueryData.fromWindow(
                                                                WidgetsBinding
                                                                    .instance
                                                                    .window)
                                                            .size
                                                            .width *
                                                        0.7,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 250, 184, 108),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    elevation: 1,
                                                    shadowColor: Color.fromARGB(
                                                        255, 250, 250, 250),
                                                  ),
                                                  onPressed: () {
                                                    if (globals
                                                        .existAddressesInAccount
                                                        .isNotEmpty) {
                                                      globals.immovable =
                                                          !immovable;
                                                      globals.flag =
                                                          !globals.flag;
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              '/main_page/add_obj/obj_details');
                                                      setState(() {});
                                                    } else {
                                                      existAddressesInAccountIsEmpty();
                                                    }
                                                  },
                                                  child: Text(
                                                    globals.flag
                                                        ? globals
                                                            .generalContentArray[
                                                                'objDetailsPageText_3']
                                                            .toString()
                                                            .toUpperCase()
                                                        : "movable, select from exist"
                                                            .toString()
                                                            .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ],
                                    )),
                              ],
                          1: (BuildContext context) => <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          0.5,
                                      width: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/img/app_img/Main_pic_2.png'),
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
                                  flex: 3,
                                  child: SizedBox(
                                      width: 350,
                                      child: globals.uulidDB.isEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () async {
                                                      uulidAPIRequestFlag =
                                                          true;

                                                      globals.uulidDB.isNotEmpty
                                                          ? setState(() {
                                                              selectNextUULIDLevel();
                                                              print(
                                                                  "Updating current UI");
                                                              uulidAPIRequestFlag =
                                                                  false;
                                                            })
                                                          : await getUULID(0, 0)
                                                              .then((value) =>
                                                                  value.runtimeType !=
                                                                          String
                                                                      ? setState(
                                                                          () {
                                                                          selectNextUULIDLevel();
                                                                          uulidAPIRequestFlag =
                                                                              false;
                                                                        })
                                                                      : setState(
                                                                          () {
                                                                          noAPIResponse();

                                                                          uulidAPIRequestFlag =
                                                                              false;
                                                                        }));
                                                    },
                                                    icon: Icon(
                                                      Icons.refresh,
                                                      size: 24.0,
                                                    ),
                                                    label: Text(
                                                        'GET UULID'), // <-- Text
                                                  )
                                                ])
                                          : ListView.builder(
                                              itemCount: globals.uulidDB.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return ListView(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(20),
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 290,
                                                        height: 30,
                                                        child: DropdownButton2(
                                                          buttonWidth: 290,
                                                          isExpanded: true,
                                                          isDense: true,
                                                          underline: Container(
                                                            height: 2,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    124,
                                                                    160,
                                                                    209),
                                                          ),
                                                          value: index == 0
                                                              ? globals
                                                                  .dropdownUULIDValueLevel0
                                                              : index == 1
                                                                  ? globals
                                                                      .dropdownUULIDValueLevel1
                                                                  : index == 2
                                                                      ? globals
                                                                          .dropdownUULIDValueLevel2
                                                                      : index ==
                                                                              3
                                                                          ? globals
                                                                              .dropdownUULIDValueLevel3
                                                                          : index == 4
                                                                              ? globals.dropdownUULIDValueLevel4
                                                                              : index == 5
                                                                                  ? globals.dropdownUULIDValueLevel5
                                                                                  : index == 6
                                                                                      ? globals.dropdownUULIDValueLevel6
                                                                                      : index == 7
                                                                                          ? globals.dropdownUULIDValueLevel7
                                                                                          : index == 8
                                                                                              ? globals.dropdownUULIDValueLevel8
                                                                                              : globals.dropdownUULIDValueLevel9,
                                                          hint: Text(
                                                            'Select Item'
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      145,
                                                                      1,
                                                                      1),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    124,
                                                                    160,
                                                                    209),
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          items: (globals
                                                                  .uulidDB[
                                                                      index][
                                                                      (index)
                                                                          .toString()]
                                                                  .cast<
                                                                      String>() as List<
                                                                  String>)
                                                              .map((String
                                                                  items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(items
                                                                  .toUpperCase()),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (value) async {
                                                            uulidAPIRequestFlag =
                                                                true;
                                                            print(value);
                                                            print(
                                                                "This IS INDEX");
                                                            print(index);
                                                            print(globals
                                                                    .uulidDB[
                                                                        index][
                                                                        (index)
                                                                            .toString()]
                                                                    .indexOf(
                                                                        value ??
                                                                            'default') +
                                                                1);
                                                            final userChoice = globals
                                                                    .uulidDB[
                                                                        index][
                                                                        (index)
                                                                            .toString()]
                                                                    .indexOf(
                                                                        value ??
                                                                            'default') +
                                                                1;
                                                            index == 0
                                                                ? globals
                                                                        .dropdownUULIDValueLevel1 =
                                                                    null
                                                                : null;
                                                            index == 1
                                                                ? globals
                                                                        .dropdownUULIDValueLevel2 =
                                                                    null
                                                                : null;
                                                            index == 2
                                                                ? globals
                                                                        .dropdownUULIDValueLevel3 =
                                                                    null
                                                                : null;
                                                            index == 3
                                                                ? globals
                                                                        .dropdownUULIDValueLevel4 =
                                                                    null
                                                                : null;
                                                            index == 4
                                                                ? globals
                                                                        .dropdownUULIDValueLevel5 =
                                                                    null
                                                                : null;
                                                            index == 5
                                                                ? globals
                                                                        .dropdownUULIDValueLevel6 =
                                                                    null
                                                                : null;
                                                            index == 6
                                                                ? globals
                                                                        .dropdownUULIDValueLevel7 =
                                                                    null
                                                                : null;
                                                            index == 7
                                                                ? globals
                                                                        .dropdownUULIDValueLevel8 =
                                                                    null
                                                                : null;
                                                            index == 8
                                                                ? globals
                                                                        .dropdownUULIDValueLevel9 =
                                                                    null
                                                                : null;
                                                            setState(() {
                                                              index == 0
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel0 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 1
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel1 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 2
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel2 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 3
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel3 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 4
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel4 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 5
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel5 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 6
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel6 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 7
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel7 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 8
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel8 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              index == 9
                                                                  ? globals
                                                                          .dropdownUULIDValueLevel9 =
                                                                      value
                                                                          .toString()
                                                                  : null;
                                                              globals.uulid =
                                                                  value
                                                                      .toString();
                                                            });
                                                            print(
                                                                "This is globals.dropdownUULIDValueLevel0");
                                                            print(globals
                                                                .dropdownUULIDValueLevel0);
                                                            print(
                                                                globals.uulid);

                                                            await getUULID(
                                                                    userChoice,
                                                                    1 + index)
                                                                .then((value) => value
                                                                        .isNotEmpty
                                                                    ? setState(
                                                                        () {
                                                                        selectNextUULIDLevel();
                                                                        uulidAPIRequestFlag =
                                                                            false;
                                                                      })
                                                                    : setState(
                                                                        () {
                                                                        lastUULIDLevelReached();
                                                                        uulidAPIRequestFlag =
                                                                            false;
                                                                      }));
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    15,
                                                                    77,
                                                                    154),
                                                          ),
                                                          buttonPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15),
                                                          dropdownDecoration:
                                                              BoxDecoration(
                                                            //borderRadius: BorderRadius.circular(30),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    222,
                                                                    229,
                                                                    239),
                                                          ),
                                                          itemHeight: 40,
                                                          dropdownMaxHeight:
                                                              170,
                                                        ),
                                                      )
                                                    ]);
                                              })),
                                ),
                              ],
                          2: (BuildContext context) => <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          0.5,
                                      width: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/img/app_img/Main_pic_2.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ListView(
                                    padding: EdgeInsets.all(0.0),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'ADDITIONAL \nINFORMATION',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 36,
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Form(
                                          key: _formKey,
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
                                                            'objDetailsPageText_5']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 124, 160, 209),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                height: 40,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: controllerBrand,
                                                    onChanged: (newValue) {
                                                      globals.brandName =
                                                          controllerBrand.text;
                                                    },
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 15, 77, 154),
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: Color.fromARGB(
                                                              255,
                                                              124,
                                                              160,
                                                              209),
                                                        ),
                                                      ),
                                                      labelText: '',
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your Brand name';
                                                      }
                                                      return null;
                                                    }),
                                              ),
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
                                                            'objDetailsPageText_6']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 124, 160, 209),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                height: 40,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller:
                                                        controllerCommercialName,
                                                    onChanged: (newValue) {
                                                      globals.commercialName =
                                                          controllerCommercialName
                                                              .text;
                                                    },
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 15, 77, 154),
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: Color.fromARGB(
                                                              255,
                                                              124,
                                                              160,
                                                              209),
                                                        ),
                                                      ),
                                                      labelText: '',
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your Commercial name';
                                                      }
                                                      return null;
                                                    }),
                                              ),
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
                                                            'objDetailsPageText_7']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 124, 160, 209),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                height: 40,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller:
                                                        controllerSerialNumber,
                                                    onChanged: (newValue) {
                                                      globals.serialNumber =
                                                          controllerSerialNumber
                                                              .text;
                                                    },
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 15, 77, 154),
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: Color.fromARGB(
                                                              255,
                                                              124,
                                                              160,
                                                              209),
                                                        ),
                                                      ),
                                                      labelText: '',
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your Serial Number';
                                                      }
                                                      return null;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                          3: (BuildContext context) => <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          0.5,
                                      width: MediaQueryData.fromWindow(
                                                  WidgetsBinding
                                                      .instance.window)
                                              .size
                                              .width *
                                          1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/img/app_img/Main_pic_2.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(300, 200),
                                        backgroundColor:
                                            Color.fromARGB(255, 212, 223, 236),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          color:
                                              Color.fromARGB(255, 15, 77, 154),
                                          fontSize: 32,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                        },
                        fallbackBuilder: (BuildContext context) => <Widget>[
                          Text('Uuups, no such page found'),
                        ],
                      ),
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
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.black.withOpacity(0.0),
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.circle,
                                  color: (counter == 3)
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
            counter == 3
                ? cameraPermissionStatus
                    ? Column(children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                1,
                            color: Colors.grey.withOpacity(0.3),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 200),
                                child: SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 246, 246, 246),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 1,
                                      shadowColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                    ),
                                    onPressed: () {
                                      openAppSettings();
                                    },
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Camera permission is not granted"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 15, 77, 154),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Please, give access to App"
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 124, 160, 209),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ])
                    : Container()
                : uulidAPIRequestFlag
                    ? Container(
                        width: MediaQueryData.fromWindow(
                                    WidgetsBinding.instance.window)
                                .size
                                .width *
                            1,
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(
                          child: LoadingAnimationWidget.twoRotatingArc(
                            color: Color.fromARGB(255, 15, 77, 154),
                            size: 50,
                          ),
                        ),
                      )
                    : Container()
          ]));
    });
  }
}
