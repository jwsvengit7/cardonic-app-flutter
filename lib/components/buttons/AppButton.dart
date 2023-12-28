import 'package:cardmonix/utils/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const AppButton({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
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
      ),
    );
  }
}
