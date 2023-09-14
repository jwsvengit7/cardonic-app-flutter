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
        title: Text(coinName + " Coin"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.center,
              width: 400,
              height: 100,
              child: Image.network(
                coinImage,
                width: 60,
                height: 60,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  
                  
                  ),
                
                ],
               
              ),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 400,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
