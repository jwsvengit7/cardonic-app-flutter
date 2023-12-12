import 'package:cardmonix/Screens/User/history.dart';
import 'package:flutter/material.dart';

class Views extends StatelessWidget {
  final HistoryItem item;

  Views({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View History")),
      body: Container(alignment: Alignment.center),
    );
  }
}
