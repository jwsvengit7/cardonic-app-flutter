import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';

class Otp extends StatefulWidget {
  final String email;

  const Otp({super.key, required this.email});

  @override
  OtpState createState() => OtpState();
}

class OtpState extends State<Otp> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP")),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 150,
            alignment: Alignment.center,
            child: Image.asset(
              'images/logo-app.png',
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Enter the OTP sent to ${widget.email}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          _buildOtpInputFields(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 117, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Verify OTP",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resendOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 127, 225),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Resend OTP",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildOtpDigitField(_otpController1),
        _buildOtpDigitField(_otpController2),
        _buildOtpDigitField(_otpController3),
        _buildOtpDigitField(_otpController4),
      ],
    );
  }

  Widget _buildOtpDigitField(TextEditingController controller) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(229, 239, 236, 236),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 60,
        width: 64,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.headlineMedium,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
        ),
      ),
    );
  }

  void _verifyOtp() async {
    String otp = _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text;

    try {
      final response =
          await APIService().verifyOtp(email: widget.email, otp: otp);
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic successMessage = responseData['data'];
      print(successMessage);
      print(response.statusCode);
      if (response.statusCode == 202) {
        alert(successMessage, "Success");
      } else {
        alert(successMessage, "Warning");
        //okparaifeanyi21@gmail.com
      }
    } catch (e) {
      print(e);
      alert("Error occurred", "Warning");
    }
  }

  void success() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  void _stay() {}

  void alert(String message, String type) {
    AwesomeDialog(
        context: context,
        dialogType: type == "Warning" ? DialogType.warning : DialogType.success,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: type,
        desc: message,
        btnOkOnPress: () {
          type == "Success" ? success() : _stay();
        }).show();
  }

  void _resendOtp() {
    // Implement logic to resend OTP here.
  }

  @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    super.dispose();
  }
}
