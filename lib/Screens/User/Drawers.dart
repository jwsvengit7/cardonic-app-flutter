import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/Screens/User/Giftcards/giftcardRate.dart';
import 'package:cardmonix/Screens/User/history.dart';
import 'package:cardmonix/Screens/login_signup.dart';

import 'package:flutter/material.dart';
import 'package:cardmonix/Screens/User/Giftcards/giftcardsItem.dart';
import 'package:cardmonix/Screens/User/settings.dart';

import 'package:provider/provider.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 70, 41),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (authProvider.user != null)
                  Text(
                    authProvider.user!.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                if (authProvider.user != null)
                  Text(
                    authProvider.user!.email,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
            title: const Text('Sell Giftcards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Giftcards()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
            title: const Text('Giftcards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Item()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.currency_bitcoin),
            title: const Text('Exchange Coin'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
