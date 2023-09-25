import 'package:cardmonix/screen/User/history.dart';
import 'package:flutter/material.dart';

class Views extends StatelessWidget {
  HistoryItem item;

  Views({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View History")),
      body: Container(alignment: Alignment.center),
    );
  }
}
