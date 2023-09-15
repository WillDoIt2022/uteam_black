import 'package:flutter/material.dart';
//Packages
import 'package:flutter_bloc/flutter_bloc.dart';
//widgets
import '../Widgets/uulid_api.dart';//fetch uulid DB
import '../Widgets/footer_menu.dart';
//Settings
import '../globals.dart' as globals;
import '../BLoC/obj_details_counter.dart';

// ignore_for_file: prefer_const_constructors

class AddObjPage extends StatefulWidget {
  const AddObjPage({Key? key})
      : super(key: key); //mistake"use key in widget constructions"
  @override
  State<StatefulWidget> createState() {
    return _AddObj();
  }
}


class _AddObj extends State<AddObjPage> {
  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, //remove the debug banner "Demo"



    return WillPopScope(onWillPop: () async {
      Navigator.pushNamedAndRemoveUntil(
          context, '/main_page', (Route<dynamic> route) => false);
      return false;
    }, child: BlocBuilder<CounterNav, int>(builder: (context, counter) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 25, left: 30),
                    elevation: 0.0,
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/main_page'));
                    //Navigator.pop(context);
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
              ),
            ),
            Expanded(
              flex: 6,
              child: Stack(children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "${globals.accountName} account".toString().toUpperCase(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 77, 154),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        0.5,
                    width: MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window)
                            .size
                            .width *
                        1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/app_img/Main_pic_2.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 212, 223, 236),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 1,
                          shadowColor: Color.fromARGB(255, 250, 250, 250),
                        ),
                        onPressed: () {
                          globals.flag = true;
                          globals.objectId = "";
                          globals.level = "";
                          globals.uulid = "";
                          globals.uulid = "";
                          globals.fullPath = "";
                          globals.uulidDB = [];
                          globals.objectInfo= "";
                          globals.objectAccess= "";
                          
                          getUULID(0,0);
                          BlocProvider.of<CounterNav>(context)
                              .add(CounterResetEvent());
                          Navigator.pushNamed(
                              context, '/main_page/add_obj/obj_details');
                        },
                        child: Text(
                          globals.generalContentArray['addObjPageText_1']
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 15, 77, 154),
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: FooterMenu(),
            ),
          ],
        ),
      );
    }));
  }
}
