import 'package:cardmonix/helpers/state_manager.dart';
import 'package:cardmonix/onboarding_screen_example/onboarding_page.dart';
import 'package:cardmonix/screen/User/giftcards/giftcardRate.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/login_signup.dart';
import 'package:cardmonix/screen/create_account.dart';
import 'package:cardmonix/screen/User/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? screen;
Future<void> main() async {
  await dotenv.load();
  Get.put(AuthController());
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  screen = pref.getInt("intscreen");
  await pref.setInt("intscreen", 1);
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
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: screen == 0 || screen == null ? "/" : "/login",
      routes: {
        '/': (context) => const OnBoardingPage(),
        '/login': (context) => const LoginSignupScreen(),
        '/signup': (context) => const CreateAccountScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/rate': (context) => const RateCard(),
      },
    );
  }
}
