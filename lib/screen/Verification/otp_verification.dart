import 'package:cardmonix/screen/Login_Signup.dart';
import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Otp extends StatefulWidget {
  final String email;

  Otp({required this.email});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();
  SizedBox size = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP")),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 150,
            alignment: Alignment.center,
            child: Image.asset(
              'images/logo-app.jpeg',
              width: 70,
              height: 70,
            ),
          ),
          size,
          Text(
            "Enter the OTP sent to ${widget.email}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          size,
          _buildOtpInputFields(),
          size,
          ElevatedButton(
              onPressed: _verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 244, 117, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Verify OTP",
                style: TextStyle(color: Colors.white),
              )),
          size,
          ElevatedButton(
              onPressed: _resendOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 7, 127, 225),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Resend OTP",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildOtpDigitField(),
        _buildOtpDigitField(),
        _buildOtpDigitField(),
        _buildOtpDigitField(),
      ],
    );
  }

  Widget _buildOtpDigitField() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(229, 239, 236, 236), // Shadow color
            blurRadius: 6.0, // Spread radius
            offset: Offset(0, 2), // Shadow position (horizontal, vertical)
          ),
        ],
      ),
      child: SizedBox(
        height: 60,
        width: 64,
        child: TextFormField(
          onSaved: (pin1) {},
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.displayLarge,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),
    );
  }

  void _verifyOtp() {
    String otp = _otpController.text;
  }

  void _resendOtp() {}

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
