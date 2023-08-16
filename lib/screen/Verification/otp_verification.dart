import 'package:cardioc/screen/Login_Signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Otp extends StatelessWidget {
  final _otp = TextEditingController();

  SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: 400,
                color: Colors.red,
                child: Image.asset(
                  'images/bg.jpg',
                  width: MediaQuery.of(context).size.width - 90,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 400,
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
                      _buildInputField(hintText: 'OTP', controller: _otp),
                      spaceHieigt,
                      spaceHieigt,
                      _buildElevatedButton(),
                      spaceHieigt,
                      _wrightContent("Already have an account", "Log In"),
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
          child: const Text("Login"),
        ));
  }

  Widget _buildInputField({
    required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
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
          print(_otp.text);
        },
        child: Container(
          width: 280,
          height: 50,
          child: const Center(
            child: Text('Enter OTP'),
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

  Widget _wrightContent(String text, String text2) {
    return GestureDetector(
      onTap: () {
        Get.to(LoginSignupScreen(), transition: Transition.cupertino);
      },
      child: SizedBox(
        width: 250,
        height: 50,
        child: Center(
          child: Column(children: [
            Text(text),
            Text(text2),
          ]),
        ),
      ),
    );
  }
}
