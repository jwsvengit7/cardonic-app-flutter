import 'package:flutter/material.dart';
import 'package:cardmonix/Screens/User/Pin/CreatePin.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  SecurityState createState() => SecurityState();
}
Color color = const Color.fromARGB(255, 237, 70, 41);
class SecurityState extends State<Security> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[

        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ChangePin()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create Pin",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.password),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ChangePin()),
              // );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pin Block",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.history),
              ],
            ),
          ),
        ),

      ]),
    );
  }
}