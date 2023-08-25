import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
    );
  }
}
