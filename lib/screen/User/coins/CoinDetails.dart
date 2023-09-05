import 'package:flutter/material.dart';

class CoinDetailScreen extends StatelessWidget {
  final String coinName;
  final double coinPrice;
  final String coinImage;

  CoinDetailScreen({
    required this.coinName,
    required this.coinPrice,
    required this.coinImage,
  });

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
