import 'package:cardmonix/Components/input/input_field.dart';
import 'package:cardmonix/Screens/Verification/otp_verification.dart';
import 'package:cardmonix/Screens/login_signup.dart';
import 'package:cardmonix/Services/api_service.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:cardmonix/utils/imageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:cardmonix/Helpers/provider.dart';
import 'package:provider/provider.dart';

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



  void _registerUser() async {
    if (_passwordController.text != _cpasswordController.text) {
      alert("Password does not Match", "Warning");
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.setIsFetching(true);

    try {
      authProvider.setIsFetching(true);
      final response = await APIService().createAccount(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );

      final dynamic responseData = json.decode(response.data);
      final dynamic successMessage = responseData['payload'];

      if (successMessage != null &&
          successMessage['email'] == _emailController.text) {
        authProvider.setIsFetching(false);
        alert("OTP has been sent to your inbox", "Success");
      } else {
        authProvider.setIsFetching(false);
        alert("Registration failed. Please try again.", "Warning");
      }
    } catch (e) {
      print(e);
      authProvider.setIsFetching(false);
      alert("Error occurred", "Warning");
    } finally {
      authProvider.setIsFetching(false); // Reset the loading state
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
                    Utils.sizedBoxHeight(20),
                    Image.asset(
                      LOGO,
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    Utils.sizedBoxHeight(20),
                    InputField(
                      hintText: 'Username',
                      controller: _usernameController,
                    ),
                    Utils.sizedBoxHeight(20),
                    InputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    Utils.sizedBoxHeight(20),
                    InputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Utils.sizedBoxHeight(20),
                    InputField(
                      hintText: 'Re-Password',
                      controller: _cpasswordController,
                      obscureText: true,
                    ),
Utils.sizedBoxHeight(20),
                    buildElevatedButton(context, authProvider),
Utils.sizedBoxHeight(20),
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

  Widget buildElevatedButton(BuildContext context, AuthProvider authProvider) {
    return ElevatedButton(
      onPressed: authProvider.isFetching ? null : _registerUser,
      style: ElevatedButton.styleFrom(
          backgroundColor: authProvider.isFetching ? Colors.grey : Colors.red),
      child: SizedBox(
        width: 280,
        height: 50,
        child: Center(
          child: authProvider.isFetching
              ? const Center(
                  child: LoadingSpinner(),
                )
              : const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
