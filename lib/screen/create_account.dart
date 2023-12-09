import 'package:cardmonix/components/input/input_field.dart';
import 'package:cardmonix/screen/Verification/otp_verification.dart';
import 'package:cardmonix/screen/login_signup.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  SizedBox spaceHieigt = const SizedBox(height: 20);

  void _registerUser() async {
    if (_passwordController.text != _cpasswordController.text) {
      alert("Password does not Match", "Warning");
      return;
    }
    try {
      final response = await APIService().createAccount(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text);

      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic successMessage = responseData['data'];
      print(successMessage);
      (successMessage == "Registered successful")
          ? alert("Otp Have been sent to your inbox'", "Success")
          : alert(successMessage, "Warning");
    } catch (e) {
      print(e);
      alert("Error occurred", "Warning");
    }
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
              Get.to(const LoginSignupScreen());
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
                "Login",
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
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 100,
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
                    Image.asset(
                      'images/logo-app.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    spaceHieigt,
                    InputField(
                      hintText: 'Username',
                      controller: _usernameController,
                    ),
                    spaceHieigt,
                    InputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    spaceHieigt,
                    InputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    spaceHieigt,
                    InputField(
                      hintText: 'Re-Password',
                      controller: _cpasswordController,
                      obscureText: true,
                    ),
                    spaceHieigt,
                    buildElevatedButton(context),
                    spaceHieigt,
                    _wrightContent("Already have an account", "Log In"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _registerUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const SizedBox(
        width: 280,
        height: 50,
        child: Center(
          child: Text(
            'Signup',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void otp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Otp(email: _emailController.text),
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
          type == "Success" ? otp() : _stay();
        }).show();
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
