import 'package:cardmonix/screen/Login_Signup.dart';
import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Otp extends StatelessWidget {
  final _otp = TextEditingController();
  String url = "http://172.20.10.2:8085/api/v1/auth/otp_verify";
  final _formKey = GlobalKey<FormState>();
  final String email;

  Otp({required this.email});

  SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OTP")),
        body: Form(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: 60,
                width: 64,
                child: TextFormField(
                  onSaved:(pin1){

                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ))
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          mouseCursor: SystemMouseCursors.alias,
          child: const Text("OTP"),
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

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _verifileOtp(context);
          }
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

  void _verifileOtp(BuildContext context) async {
    String otp = _otp.text;
    Map<String, dynamic> requestBody = {
      'email': email,
      'otp': otp,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, "Failed to verify OTP.");
      }
    } catch (error) {
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('OK'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verified'),
          content: const Text('User have been Verified'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }
}
