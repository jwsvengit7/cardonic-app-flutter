import 'package:cardmonix/Screens/User/dashboard.dart';
import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';
enum TypeCoin { ETH, USDT, BTC }

class WalletCard extends StatefulWidget {

  @override
  WalletCardState createState() => WalletCardState();
  final WalletResponse item;
  final int index;
  List<Coin> coinData;
  WalletCard(
      {super.key,
      required this.item,
      required this.index,
      required this.coinData});
}



class WalletCardState extends State<WalletCard> {
  String getImage(String name) {
    final matchingCoin = widget.coinData.firstWhere(
      (coin) => coin.name == name,
    );
    return matchingCoin.image;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      },
      child: Container(
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
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.network(
                //   getImage(widget.item.coin),
                //   width: 40,
                //   height: 40,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "widget.item.coin",
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 85, 83, 83),
                      ),
                    ),
                    Text(
                      TypeCoin.values[widget.index].name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Utils.sizedBoxHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Balance:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${widget.item.card_balance}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 85, 83, 83),
                  ),
                ),
              ],
            ),
             Utils.sizedBoxHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Value in USD:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${widget.item.crypto_balance}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 85, 83, 83),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
