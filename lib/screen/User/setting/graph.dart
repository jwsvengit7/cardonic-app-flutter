import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  @override
  GraphState createState() => GraphState();
}

class GraphState extends State<Graph> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graph"),
      ),
    );
  }
}
