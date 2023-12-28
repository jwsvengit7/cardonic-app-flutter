import 'package:cardmonix/Screens/User/dashboard.dart';
import 'package:cardmonix/Services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cardmonix/utils/imageUtils.dart';
import 'package:cardmonix/Components/buttons/AppButton.dart';
class ChangePin extends StatefulWidget {

  @override
  ChangePinState createState() => ChangePinState();
}

class ChangePinState extends State<ChangePin> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final String  prompt=  "Kindly Enter To Create Transaction Pin ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Pin")),
      body: Column(

        children: [
          Center(
            child:Image.asset(PIN_IMAGE,width:130)
          ),
          const SizedBox(height: 40),
          Center(
          child: Text(
           prompt,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          const SizedBox(height: 50),
          _buildOtpInputFields(),

          const SizedBox(height: 70),

          AppButton(
            text: "Create Pin",
            onClicked: () {
              _createPin;
            },
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


  }

  void success() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
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

  void _createPin() {
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
