import 'dart:convert';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class CoinDetailScreen extends StatefulWidget {
  final String coinName;
  final double coinPrice;
  final String coinImage;

  const CoinDetailScreen({
    Key? key,
    required this.coinName,
    required this.coinPrice,
    required this.coinImage,
  }) : super(key: key);

  @override
  CoinDetailScreenState createState() => CoinDetailScreenState();
}

class CoinDetailScreenState extends State<CoinDetailScreen> {
  String walletId = '';
  String imagePath = '';
  TextEditingController field = TextEditingController();
  String pasteValue = '';

  @override
  void initState() {
    super.initState();
    if (widget.coinName == "Bitcoin") {
      walletId = "eyyfhke8chjnd84835434r3rdd4433r43r443343bkkdkcdcserfd";
      imagePath = "images/coins/usdt.jpeg";
    }
  }

  double amount = 0.0;
  var divider = const Divider();

  void copyWalletIdToClipboard() {
    FlutterClipboard.copy(walletId).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wallet ID copied to clipboard!"),
        ),
      );
    });
  }

  void _buycoin(String coin, double amount) async {
    try {
      final String? saveToken = await APIService().getStoredToken();

      final response = await APIService().tradeCoin(saveToken!, coin, amount);

      final Map<String, dynamic> data = json.decode(response.body);
      final dynamic api = data["data"];
      print(api);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.coinName} Coin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Row(
                children: [
                  Image.network(
                    widget.coinImage,
                    fit: BoxFit.contain,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  Text('Buy ${widget.coinName}'),
                ],
              ),
            ),
            divider,
            ListTile(
              leading: const Icon(Icons.copy),
              title: Text('Wallet ID: $walletId'),
              onTap: copyWalletIdToClipboard,
            ),
            divider,
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text('Price: \$${widget.coinPrice.toStringAsFixed(2)}'),
            ),
            divider,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: field,
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _buycoin(widget.coinName, amount);
                print('Buying ${widget.coinName} with $amount');
              },
              child: Text('Buy ${widget.coinName}'),
            ),
          ],
        ),
      ),
    );
  }
}
