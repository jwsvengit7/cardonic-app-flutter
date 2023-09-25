import 'dart:convert';
import 'package:cardmonix/screen/User/view/viewHistory.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';

enum TransactionType { Deposit, Pending }

class HistoryItem {
  final int depositId;
  final double amountInCurrency;
  final double amount;
  final String coin;
  final String status;
  final String image;
  final String transId;
  final String? proof;

  HistoryItem({
    required this.depositId,
    required this.amountInCurrency,
    required this.amount,
    required this.coin,
    required this.image,
    required this.status,
    required this.transId,
    this.proof,
  });
}

class History extends StatefulWidget {
  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  List<HistoryItem> items = [];

  // Fetch deposit history data from the API
  Future<void> fetchDeposit() async {
    try {
      final savedToken = await APIService().getStoredToken();
      final response = await APIService().getAlldeposit(savedToken);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> api = data["data"];

        setState(() {
          items = api.reversed.map((itemData) {
            return HistoryItem(
              depositId: itemData['depositId'],
              amountInCurrency: itemData['amountInCurrency'],
              amount: itemData['amount'],
              coin: itemData['coin'],
              image: itemData['image'],
              status: itemData['status'],
              transId: itemData['transId'],
              proof: itemData['proof'],
            );
          }).toList();
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDeposit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return TransactionCard(item: item);
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final HistoryItem item;

  TransactionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Views(item: item),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
            leading: Icon(
              item.status == "PENDING" ? Icons.access_time : Icons.check_circle,
              color: item.status == "PENDING" ? Colors.orange : Colors.green,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.coin} ${item.amountInCurrency}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 85, 83, 83)),
                    ),
                    Text(
                      'Amount \$${item.amount}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Image.network(item.image, width: 40, height: 40)
              ],
            )),
      ),
    );
  }
}
