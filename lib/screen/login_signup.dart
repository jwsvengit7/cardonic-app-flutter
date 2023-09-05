import 'package:cardmonix/service/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/create_account.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:cardmonix/screen/User/dashboard.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SizedBox spaceHeight = SizedBox(height: 20);

  void _handleLogin() async {
    try {
      final response = await APIService().login(
          email: _emailController.text, password: _passwordController.text);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token =
            responseData['data']['responseAccess']['jwt-token']; // Correct key

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print(token);

        _showSuccessDialog(context, token);
      } else {
        final responseData = json.decode(response.body);
        final message =
            responseData['data']['data']; // Use 'message' from the response

        _showMessageWarning(
          context,
          responseData['message'] ?? message.toString(),
        );
        print("1");
      }
    } catch (e) {
      print('Error:');
      _showMessageWarning(context, "Error occurred");
    }
  }

  void _showSuccessDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Success'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showMessageWarning(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

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
                    spaceHeight,
                    SvgPicture.asset(
                      'images/logo-app.jpeg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    spaceHeight,
                    _buildInputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    spaceHeight,
                    _buildInputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    spaceHeight,
                    _buildElevatedButton(),
                    spaceHeight,
                    _wrightContent("Don't have an account", "Create one"),
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
        child: const Icon(Icons.air_rounded, color: Colors.blueAccent),
      ),
    );
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
      onPressed: _handleLogin,
      child: const SizedBox(
        width: 280,
        height: 50,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _wrightContent(String text, String text2) {
    return GestureDetector(
      onTap: () {
        Get.to(CreateAccountScreen(), transition: Transition.cupertino);
      },
      child: SizedBox(
        width: 250,
        height: 70,
        child: Center(
          child: Column(children: [
            Text(text),
            Text(text2),
            Icon(Icons.air_rounded, color: Colors.blueAccent),
          ]),
        ),
      ),
    );
  }
}
