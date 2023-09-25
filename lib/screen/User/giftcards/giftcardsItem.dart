import 'package:cardmonix/screen/User/dto/response/Giftcard.dart';
import 'package:cardmonix/screen/User/footer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  final List<Giftcard> card;
  Item({required this.card});

  SizedBox sizedBox = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [], title: const Text("APPS")),
      body: SafeArea(
        child: buildMainUI(context),
      ),
      bottomNavigationBar: Footer(),
    );
  }

  Widget buildMainUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBox,
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Image.asset(
              "images/logo-app.jpeg",
              width: 80,
              height: 80,
            ),
          ),
          sizedBox,
          Wrap(
            spacing: 15,
            runSpacing: 10,
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              for (final card in card)
                Container(
                  width: 180,
                  height: 250,
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            card.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            card.type,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text("Price: \$${card.price}"),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
