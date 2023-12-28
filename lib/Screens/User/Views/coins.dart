import 'package:cardmonix/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/Screens/User/Coins/CoinDetails.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFirst extends StatefulWidget {
  const HomeFirst({super.key});

  @override
  HomeFirstState createState() => HomeFirstState();
}

class HomeFirstState extends State<HomeFirst> {
  SizedBox spaceHeight = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 20, top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: authProvider.coin!.map((value) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CoinDetailScreen(
                          coinName: value.name,
                          coinPrice: value.currentPrice,
                          coinImage: value.image,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    height: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.network(
                                value.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          value.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${value.currentPrice}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                          ),
                          child: const Text(
                            "Sell",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

 }
