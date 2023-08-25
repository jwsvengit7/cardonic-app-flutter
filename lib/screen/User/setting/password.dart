import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> {
  SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 100,
            height: 150,
          ),
          buildInputField(),
          spaceHieigt,
          spaceHieigt,
          buildInputField(),
          spaceHieigt,
          _buildElevatedButton()
        ],
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
          width: 280,
          height: 50,
          child: Center(
            child: Text('Change Password'),
          ),
        ));
  }
}
