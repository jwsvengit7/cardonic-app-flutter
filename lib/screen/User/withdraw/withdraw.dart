import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:cardmonix/utils/utils.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  WalletResponse? balance = Auth.auth().balance.value;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Withdraw")),
      body: Container(
        child: Text("${balance?.balance_amount}"),
      ),
    );
  }
}
