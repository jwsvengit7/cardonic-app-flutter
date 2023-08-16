import 'package:cardioc/screen/User/setting/account.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
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
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
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
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
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
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
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
        Container(
          width: 90,
          padding: EdgeInsets.all(20),
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
      ]),
    );
  }
}
