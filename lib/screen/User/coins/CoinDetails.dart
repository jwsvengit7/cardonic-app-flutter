import 'package:flutter/material.dart';

class CoinDetailScreen extends StatelessWidget {
  final String coinName;

  CoinDetailScreen({required this.coinName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName),
      ),
      body: Center(
        child: Text(
          coinName,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
