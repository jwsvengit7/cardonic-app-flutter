import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/create_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:cardmonix/screen/User/dashboard.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SizedBox spaceHeight = const SizedBox(height: 20);

  void _handleLogin() async {
    try {
      final response = await APIService().login(
          email: _emailController.text, password: _passwordController.text);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['data']['responseAccess']['jwt-token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print(token);
        alert('Login succesful', "Success");
      } else {
        print(response.statusCode);
        final responseData = json.decode(response.body);
        final message = responseData['data']['data'];
        alert(responseData['message'] ?? message.toString(), "Warning");
      }
    } catch (e) {
      print(e);
      alert("Error occured", "Warning");
    }
  }

  void _dashboard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  void _stay() {
    return null;
  }

  void alert(String message, String type) {
    AwesomeDialog(
        context: context,
        dialogType: type == "Warning" ? DialogType.warning : DialogType.success,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: type,
        desc: message,
        btnOkOnPress: () {
          type == "Success" ? _dashboard() : _stay();
        }).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: 400,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 250,
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
                    Image.asset(
                      'images/logo-app.png',
                      width: 70,
                      height: 70,
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
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const SizedBox(
        width: 280,
        height: 50,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _wrightContent(String text, String text2) {
    return SizedBox(
      width: 250,
      child: Center(
        child: Column(children: [
          Text(text),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateAccountScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 117, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Container(
              width: 100,
              height: 40,
              alignment: Alignment.center,
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
