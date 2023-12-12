import 'package:cardmonix/Components/input/input_field.dart';
import 'package:cardmonix/DTO/Response/User.dart';
import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/Services/api_service.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/Screens/create_account.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:cardmonix/Screens/User/dashboard.dart';
import '../utils/validate.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  LoginSignupScreenState createState() => LoginSignupScreenState();
}

class LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SizedBox spaceHeight = const SizedBox(height: 20);

void _handleLogin() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  authProvider.setIsFetching(true);

  try {
    final response = await APIService().login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
   
      final User user = User.fromJson(responseData);

      String? token = user.token;
      authProvider.setIsFetching(false);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      authProvider.setUser(user);
 print(responseData);
      alert('Login successful', 'Success');
    } else {
      authProvider.setIsFetching(false);

      final responseData = json.decode(response.body);
     
      final message = responseData['message'];
      alert(message ?? 'Unknown error occurred', 'Warning');
    }
  } catch (e) {
    authProvider.setIsFetching(false);
    alert('An error occurred', 'Warning');
  }
}


  void _dashboard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
          type == "Success" ? _dashboard() : _stay();
        }).show();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                    InputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    Utils.sizedBoxHeight(10),
                    Text(validateEmail(_emailController)),
                    spaceHeight,
                    InputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    spaceHeight,
                    _buildElevatedButton(authProvider),
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

  Widget _buildElevatedButton(AuthProvider authProvider) {
    return ElevatedButton(
      onPressed: authProvider.isFetching ? null : _handleLogin,
      style: ElevatedButton.styleFrom(
          backgroundColor: authProvider.isFetching ? Colors.grey : Colors.red),
      child: SizedBox(
        width: 280,
        height: 50,
        child: authProvider.isFetching
            ? const Center(
                child: LoadingSpinner(),
              )
            : const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
          Utils.sizedBoxHeight(20),
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

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
