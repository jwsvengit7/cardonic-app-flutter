import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  State<LoginSignupScreen> createState() => LoginSignupScreenState();
}

class LoginSignupScreenState extends State<LoginSignupScreen> {
  var _email = "";
  var _password = "";
  SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      spaceHieigt,
                      SvgPicture.asset(
                        'images/logo.svg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      spaceHieigt,
                      _buildInputField(
                        hintText: 'Email',
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      spaceHieigt,
                      _buildInputField(
                        hintText: 'Password',
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      spaceHieigt,
                      _buildElevatedButton(),
                      spaceHieigt,
                      _buildColoredBox(Colors.white),
                      _wrightContent(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          mouseCursor: SystemMouseCursors.alias,
          child:const  Text("Login"),
        ));
  }

  Widget _buildInputField({
    required String hintText,
    bool obscureText = false,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          print('Button Pressed!');
        },
        child: Container(
          width: 250,
          height: 60,
          child: const Center(
            child: Text('Login'),
          ),
        ));
  }

  Widget _buildColoredBox(Color color) {
    return Container(
      width: 300,
      height: 80,
      color: color,
    );
  }

  Widget _wrightContent() {
    return Container(
      width: 200,
      height: 20,
      color: Colors.blue.shade800,
    );
  }
}
