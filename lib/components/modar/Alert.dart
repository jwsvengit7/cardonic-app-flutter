import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Alert {
  void alert(String message, String type, BuildContext context) {
    AwesomeDialog(
            context: context,
            dialogType:
                type == "Warning" ? DialogType.warning : DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: type,
            desc: message,
            btnOkOnPress: () {})
        .show();
  }
}
