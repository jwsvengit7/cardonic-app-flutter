import 'package:cardmonix/Screens/User/Profile/profile.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));
      } else if (index == 0) {
        Navigator.pushNamed(context, '/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.red,
      unselectedItemColor: const Color.fromARGB(117, 0, 0, 0),
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.money_off_csred),
          label: 'Trade',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}