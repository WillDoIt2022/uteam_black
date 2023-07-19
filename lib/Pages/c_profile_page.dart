import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flushbar/flushbar.dart'; //notifys
import '../routes.dart';
import "../Widgets/translator.dart";
import 'package:dropdown_button2/dropdown_button2.dart';
import "../Widgets/footer_menu.dart";
import '../styles/app_textstyles.dart';
import "../Widgets/language_determiner.dart";
import '../styles/app_colors.dart';
import "../Widgets/auth.dart";
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return ProfileSettings();
  }
}

class ProfileSettings extends State<ProfilePage> {
  dynamic controllerEmail = TextEditingController(text: globals.userEmail);
  dynamic controllerName = TextEditingController(text: globals.userName);
  bool onEdit = false;
  final List<String> itemsLang = [
    'english',
    'french',
    'ukranian',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"
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
                    Navigator.pop(context);
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
                onEdit
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 25, right: 30),
                          elevation: 0.0,
                          backgroundColor: Colors.white.withOpacity(0.05),
                        ),
                        onPressed: () {},
                        child: Text(
                          "done"
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
            flex: 4,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent, // Image radius
                    backgroundImage:
                        AssetImage("assets/img/app_img/user/Unnamed_user.png"),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20, right: 10, bottom: 0, top: 0),
                    child: Text(
                      "Change photo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 182, 182, 182),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          //color: Colors.green,
                          child: Text(
                            textAlign: TextAlign.left,
                            "email".toString().toUpperCase(),
                            style: AppTextStyle.textSize13Grey,
                          ),
                        ),
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: Color.fromARGB(255, 27, 82, 157),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            controller: controllerEmail,
                            maxLines: 1,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              //filled: true,
                              //fillColor: Colors.deepPurpleAccent,
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 182, 182, 182)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 182, 182, 182)),
                              ),
                              border: InputBorder.none,
                              labelText: '',
                              hintText: '',
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(maxHeight: 32),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(right:3),
                                alignment: Alignment.centerRight,
                                icon: ImageIcon(
                                  AssetImage(
                                      "assets/img/app_img/user/Pencil.png"),
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    onEdit = !onEdit;
                                  });
                                },
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          //color: Colors.green,
                          child: Text(
                            textAlign: TextAlign.left,
                            "name".toString().toUpperCase(),
                            style: AppTextStyle.textSize13Grey,
                          ),
                        ),
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: Color.fromARGB(255, 27, 82, 157),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: controllerName,
                            maxLines: 1,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              //filled: true,
                              //fillColor: Colors.deepPurpleAccent,
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 182, 182, 182)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 182, 182, 182)),
                              ),
                              border: InputBorder.none,
                              labelText: '',
                              hintText: '',
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(maxHeight: 32),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(right:3),
                                alignment: Alignment.centerRight,
                                icon: ImageIcon(
                                  AssetImage(
                                      "assets/img/app_img/user/Pencil.png"),
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    onEdit = !onEdit;
                                  });
                                },
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .width *
                              0.8,
                          //color: Colors.green,
                          child: Text(
                            textAlign: TextAlign.left,
                            globals.generalContentArray['logInRegisteredText_3']
                                .toString()
                                .toUpperCase(),
                            style: AppTextStyle.textSize13Grey,
                          ),
                        ),
                       Container(
                            width: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                0.8,
                            height: MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .size
                                    .width *
                                0.07,
                            child: DropdownButton2(
                              buttonWidth: MediaQueryData.fromWindow(
                                          WidgetsBinding.instance.window)
                                      .size
                                      .width *
                                  0.8,
                              isExpanded: true,
                              isDense: true,
                              underline: Container(
                                height: 2,
                                color: Color.fromARGB(255, 182, 182, 182),
                              ),
                              value: globals.selectedLanguage == 'en'
                                  ? 'english'
                                  : globals.selectedLanguage == 'fr'
                                      ? 'french'
                                      : 'ukranian',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 27, 82, 157),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                              //menuMaxHeight: 200,
                              items: itemsLang.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (value) async {
                                value.toString().toLowerCase() == "english"
                                    ? value = 'en'
                                    : value.toString().toLowerCase() == "french"
                                        ? value = 'fr'
                                        : value = 'ua';
                                print(value.toString());
                                globals.language = value.toString();
                                globals.selectedLanguage = value.toString();

                                languageDeterminer();
                               await translateLanguage();
                                await Future.delayed(const Duration(seconds: 2),
                                   () {
                                  
                               });
                                setState(() {});
                              },

                              icon: ImageIcon(AssetImage("assets/img/app_img/user/Pencil.png"),),
                              buttonPadding: const EdgeInsets.only(left: 10),
                              dropdownDecoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 222, 229, 239),
                              ),

                              itemHeight: 40,
                              dropdownMaxHeight: 170,
                            ),
                          ),
                      ]),
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
              flex: 3,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQueryData.fromWindow(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.1,
                      width: MediaQueryData.fromWindow(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.middleBlueVar2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 1,
                          shadowColor: Color.fromARGB(255, 250, 250, 250),
                        ),
                        onPressed: () async {
                          await Auth().signOut();
                          await Auth().authStateChanges().then((value) => !value
                              ? Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.registrationPage,
                                  (Route<dynamic> route) => false)
                              : print("u are not signOut"));
                        },
                        child: Text(
                          "Log Out",
                          style: AppTextStyle.textSize20Light,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQueryData.fromWindow(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.1,
                      width: MediaQueryData.fromWindow(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.middleBlueVar2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 1,
                          shadowColor: Color.fromARGB(255, 250, 250, 250),
                        ),
                        onPressed: () async {
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.mainPage, (Route<dynamic> route) => false);
                        },
                        child: Text(
                          "Change account",
                          style: AppTextStyle.textSize20Light,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ])),
          Expanded(
            flex: 2,
            child: globals.accountName != "" ? FooterMenu() : Container(),
          ),
        ],
      ),
    );
  }
}
