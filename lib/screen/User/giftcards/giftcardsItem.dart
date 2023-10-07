import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Future<List<Giftcard>> card;

  Item({Key? key, required this.card}) : super(key: key);

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
          FutureBuilder<List<Giftcard>>(
            future: card,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the data to load, you can display a loading indicator.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error state here.
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                // Display the list of Giftcards.
                return Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceAround,
                  children: snapshot.data!.map((item) {
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
                                item.image,
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
                            Text("Price: \$${item.price.toStringAsFixed(2)}"),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                // Handle the case where there is no data.
                return Text("No data available.");
              }
            },
          ),
        ],
      ),
    );
  }
}
