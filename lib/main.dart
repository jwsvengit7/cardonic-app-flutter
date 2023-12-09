import 'package:cardmonix/helpers/provider.dart';
import 'package:cardmonix/OnboardingScreen/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/login_signup.dart';
import 'package:cardmonix/screen/create_account.dart';
import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? screen;
Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  screen = pref.getInt("intscreen");
  await pref.setInt("intscreen", 1);
  AuthProvider authProvider = AuthProvider();
  runApp(
    ChangeNotifierProvider.value(
      value: authProvider,
      child: const MyApp(),
    ),
  );
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
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: screen == 0 || screen == null ? "/" : "/login",
      routes: {
        '/': (context) => const OnBoardingPage(),
        '/login': (context) => const LoginSignupScreen(),
        '/signup': (context) => const CreateAccountScreen(),
        '/dashboard': (context) =>  DashboardScreen(),
      },
    );
  }
}
