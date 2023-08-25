import 'package:flutter/material.dart';

class CardContent extends StatefulWidget {
  @override
  CardState createState() => CardState();
}

class CardState extends State<CardContent> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card"),
      ),
    );
  }
}
