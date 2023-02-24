import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLoC/obj_details_counter.dart';
import '../Widgets/footer_menu.dart';
import '../globals.dart' as globals;

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
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
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
                )),
            Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 139,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/Logo_house.png'),
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
                      globals.level="";
                      globals.uulid="";
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
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
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
