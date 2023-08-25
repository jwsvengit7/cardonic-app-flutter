import 'package:cardmonix/screen/User/setting/account.dart';
import 'package:cardmonix/screen/User/setting/contact.dart';
import 'package:cardmonix/screen/User/setting/graph.dart';
import 'package:cardmonix/screen/User/setting/security.dart';
import 'package:cardmonix/screen/User/setting/wallet.dart';
import 'package:cardmonix/screen/User/setting/card.dart';
import 'package:cardmonix/screen/User/setting/password.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardContent()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Card",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.card_membership),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graph()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Graph",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.graphic_eq_sharp),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wallet()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Connect Wallet",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.wallet_giftcard),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Account()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Edit Account",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.account_box),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Password()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Passsword",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.password),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contact()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Contact Information",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.history),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Security()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Security",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Icon(Icons.security),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
