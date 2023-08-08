import 'package:cardioc/screen/Verification/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
// import 'package:http/http.dart' as http;

class  CreateAccountScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Login Account'),
        // ),
        body: Scaffold(
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
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 120,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 650,
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
                      hintText: 'Username',
                      controller: _usernameController,
                    ),
                    spaceHieigt,
                    _buildInputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    spaceHieigt,
                    _buildInputField(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                    spaceHieigt,
                    _buildInputField(
                      hintText: 'Re-Password',
                      controller: _cpasswordController,
                    ),
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
          print(_emailController);
        },
        child:  const SizedBox(
          width: 280,
          height: 50,
          child:  Center(
            child: Text('Signup'),
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
        Get.to(Otp(), transition: Transition.cupertino);
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
