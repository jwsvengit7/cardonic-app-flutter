import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:cardioc/screen/login_signup.dart';
import 'package:get/route_manager.dart';
import 'package:cardioc/screen/User/homed1.dart';
import 'package:cardioc/screen/User/footer.dart';
import 'package:cardioc/screen/login_signup.dart';

class DashboardScreen extends StatelessWidget {
  final SizedBox spaceHieigt = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 400,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 130,
                    color: const Color.fromARGB(255, 203, 216, 222),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipOval(
                            child: Image.asset(
                              'images/bg.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 200,
                          height: 70,
                        ),
                        SizedBox(
                          width: 100,
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: [
                                  const Icon(Icons.verified_user,
                                      color: Colors.blueAccent),
                                  Container(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: const Text("jwsven"),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  const Icon(Icons.settings,
                                      color: Colors.blueAccent),
                                  Container(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: const Text("Setting"),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  const Icon(Icons.logout,
                                      color: Colors.blueAccent),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginSignupScreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: const Text("Logout"),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        HomeFirst(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
