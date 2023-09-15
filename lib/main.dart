import 'package:cardmonix/screen/Verification/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/login_signup.dart';
import 'package:cardmonix/screen/create_account.dart';
import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CardMonix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/dashboard",
      routes: {
        '/': (context) => LoginSignupScreen(),
        '/signup': (context) => CreateAccountScreen(),
        '/otp': (context) => Otp(email: ""),
        '/dashboard': (context) => DashboardScreen(),
      }, //8175588238 mon gran
    );
  }
}
