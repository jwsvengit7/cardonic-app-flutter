import 'package:cardmonix/Helpers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item extends StatelessWidget {
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: 400,
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
            if (authProvider.giftcards != null &&
                authProvider.giftcards!.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: authProvider.giftcards!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display two cards per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75, // Adjust aspect ratio for card height
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = authProvider.giftcards![index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              item.image,
                              fit: BoxFit.contain,
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
                            "Price: \$${authProvider.balance!.balance_amount.toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            if (authProvider.giftcards == null ||
                authProvider.giftcards!.isEmpty)
              Center(
                child: Text("No data available."),
              ),
          ],
        ),
      ),
    );
  }
}
