import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:cardmonix/utils/utils.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  WalletResponse? balance = Auth.auth().balance.value;
  List<Giftcard>? giftcards = Auth.auth().giftcards.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Apps"),
      ),
      body: SafeArea(
        child: buildMainUI(context),
      ),
    );
  }

  Widget buildMainUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Image.asset(
              "images/logo-app.png",
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          if (giftcards != null && giftcards!.isNotEmpty)
            Wrap(
              spacing: 15,
              runSpacing: 10,
              alignment: WrapAlignment.spaceAround,
              children: giftcards!.map((item) {
                return SizedBox(
                  width: 180,
                  height: 200,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            "item.image",
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.type,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                            "Price: \$${balance!.balance_amount.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          if (giftcards == null || giftcards!.isEmpty)
            Center(
              child: Text("No data available."),
            ),
        ],
      ),
    );
  }
}
