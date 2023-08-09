import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:cardioc/screen/create_account.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cardioc/screen/User/dashboard.dart';
import 'package:network_info_plus/network_info_plus.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  LoginSignupScreenState createState() => LoginSignupScreenState();
}

class LoginSignupScreenState extends State<LoginSignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final SizedBox spaceHeight = SizedBox(height: 20);

  Future<void> loginUser(String email, String password) async {
    // final networkInfo = NetworkInfo();
    // final wifiInfo = await networkInfo.getWifiName();
    // final ipAddress = await networkInfo.getWifiIP();

    // if (wifiInfo != null && ipAddress != null) {
    try {
      final url = Uri.parse('http://192.168.2.159:8085/api/v1/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
                        'images/logo.svg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      spaceHeight,
                      _buildInputField(
                          hintText: 'Email', controller: _emailController),
                      spaceHeight,
                      _buildInputField(
                          hintText: 'Password',
                          controller: _passwordController),
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
          final email = _emailController.text;
          final password = _passwordController.text;
          loginUser(email, password);
        },
        child: const SizedBox(
          width: 280,
          height: 50,
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
        Get.to(CreateAccountScreen(), transition: Transition.cupertino);
      },
      child: SizedBox(
        width: 250,
        height: 70,
        child: Center(
          child: Column(children: [
            Text(text),
            Text(text2),
            Icon(Icons.air_rounded, color: Colors.blueAccent)
          ]),
        ),
      ),
    );
  }
}
