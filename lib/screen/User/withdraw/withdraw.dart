import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  final UserData? userData;
  final double amount;
  const Withdraw({required this.userData, required this.amount});
  WithdrawState createState() => WithdrawState();
}

class WithdrawState extends State<Withdraw> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Withdraw")),
      body: Container(
        child: Text("${widget.amount}"),
      ),
    );
  }
}
