import 'package:flutter/cupertino.dart';

String validateEmail(TextEditingController value) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.text.isEmpty) {
    _msg = "Your Email is required";
  } else if (!regex.hasMatch(value.text)) {
    _msg = "Please provide a valid Email address";
  }
  return _msg;
}
