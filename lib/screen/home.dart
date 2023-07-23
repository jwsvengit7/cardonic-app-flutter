import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void _name() {
    String name = "jackson";
    setState(() {
      name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue[100],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _name,
        tooltip: 'Show Name',
        child: const Icon(Icons.add),
      ),
    );
  }
}
