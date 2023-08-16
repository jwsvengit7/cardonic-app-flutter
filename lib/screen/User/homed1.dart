import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFirst extends StatefulWidget {
  @override
  HomeFirstState createState() => HomeFirstState();
}

class HomeFirstState extends State<HomeFirst> {
  List<Map<dynamic, String>> containerList = [
    {
      "name": "Bitcoin",
      "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
      "price": "3029",
    },
    {
      "name": "Ethereum",
      "image":
          "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
      "price": "3029",
    },
    {
      "name": "Tether",
      "image":
          "https://assets.coingecko.com/coins/images/325/large/Tether.png?1668148663",
      "price": "3029",
    },
    {
      "name": "BNB",
      "image":
          "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1644979850",
      "price": "3029",
    },
    {
      "name": "XRP",
      "image":
          "https://assets.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1605778731",
      "price": "3029",
    },
  ];

  @override
  Widget build(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          width: 390,
          height: 300,
          color: Colors.white70,
          padding: const EdgeInsets.only(top: 40),
          child: Positioned(
            bottom: 30,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 44, 86, 223),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    // spreadRadius: 5,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Balance:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '\$1000.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Monthly Status:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              children: containerList.map((value) {
                return Container(
                    width: 170,
                    height: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Image.network(
                            value["image"]!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text("Price: " + value["price"]!),
                        Text(value["name"]!),
                      ],
                    ));
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
