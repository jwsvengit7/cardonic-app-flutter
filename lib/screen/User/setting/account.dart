import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
