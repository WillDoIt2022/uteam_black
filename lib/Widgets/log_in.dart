import 'package:flutter/material.dart';
import '../Widgets/log_in_add_phone.dart';
import '../Widgets/log_in_enter_code.dart';
// ignore_for_file: prefer_const_constructors

Widget loginWidget(context, logIn, controllerPhone, controllerCode) {
  return logIn
      ? logInAddPhone(controllerPhone)
      : logInEnterCode(context, controllerCode, controllerPhone);
}
