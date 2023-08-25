import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

SizedBox spaceHieigt = const SizedBox(height: 20);

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset('images/logo.png',
                      width: 10, height: 10, fit: BoxFit.none),
                ),
                Column(children: [
                  buildInputField(),
                  spaceHieigt,
                  buildInputField(),
                  spaceHieigt,
                  _buildElevatedButton()
                ])
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {},
        child: const SizedBox(
          width: 300,
          height: 50,
          child: Center(
            child: Text('Change Password'),
          ),
        ));
  }
}
