import 'package:cardmonix/utils/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const AppButton({super.key, 
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      ),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: 300,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
