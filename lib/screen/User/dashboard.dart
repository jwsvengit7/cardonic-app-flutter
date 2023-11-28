import 'package:cardmonix/dto/response/CoinsResponse.dart';
import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:cardmonix/dto/response/User.dart';
import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:cardmonix/screen/User/wallet.dart';
import 'package:cardmonix/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/User/coins/coins.dart';
import 'package:cardmonix/screen/User/footer.dart';
import 'package:cardmonix/screen/User/Drawers.dart';
import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:cardmonix/service/api_service.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

enum TypeCoin { ETH, USDT, BTC }

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User? loggedInUser = Auth.auth().user.value;

  List<Coin> coinData = [];
  UserData? userInfo;
  List<Giftcard> giftcard = [];
  double amountApp = 0;
  List<WalletResponse> items = [];

  Future<List<Giftcard>> fetchGifcard() async {
    try {
      final savedToken = await APIService().getStoredToken();
      final response = await APIService().getAllGiftcard(savedToken);
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> list = body["data"];
      if (response.statusCode == 200) {
        return list.map((dynamic json) {
          final coinJson = json as Map<String, dynamic>;

          return Giftcard(
            image: coinJson['image'],
            type: coinJson['type'],
            price: coinJson['price'],
          );
        }).toList();
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }
    throw Exception('error fetching data');
  }

  void getWallet() async {
    try {
      final saveToken = await APIService().getStoredToken();
      final response = await APIService().getWallet(saveToken);
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> list = data["data"];
      setState(() {
        items = list.map((itemData) {
          return WalletResponse(
            walletId: itemData['walletId'],
            walletAmount: itemData['wallet_amount'],
            walletInUsd: itemData['walletInUsd'],
            coin: itemData['coin'],
          );
        }).toList();
      });
      print(items.length);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await APIService().fetchCoins(0, 10);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> content = data['data']['content'];

        setState(() {
          coinData = content.map((coinJson) {
            return Coin(
              coin_id: coinJson['coin_id'],
              name: coinJson['name'],
              image: coinJson['image'],
              current_price: coinJson['current_price'],
              old_price: coinJson['old_price'],
              activate: coinJson['activate'],
            );
          }).toList();
        });
      } else {
        print("Error");
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error occurred: $error");
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchBalance() async {
    final savedToken = await APIService().getStoredToken();

    try {
      final response = await APIService().fetchUserDetails(savedToken);

      if (response.statusCode == 200) {
        final dynamic userDetailsJson = json.decode(response.body);
        final dynamic userdetails = userDetailsJson["data"];
        // setState(() {
        //   userInfo = Balance(
        //     amount: BigInt.zero,
        //     balanceId: BigInt.zero,
        //     currency: "NGN",
        //   );
        // });
        amountApp = userdetails["balance"]["amount"];
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  String getImage(String name) {
    return coinData
        .firstWhere(
          (coin) => coin.name == name,
        )
        .image;
  }

  @override
  void initState() {
    super.initState();
    fetchGifcard();
    fetchData();
    fetchBalance();
    getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(child: Drawers(card: fetchGifcard())),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leadingWidth: MediaQuery.devicePixelRatioOf(context),
        title: Container(
          width: 390,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: const SizedBox(
                  width: 40,
                  height: 40,
                ),
              ),
              Container(
                height: 100,
                alignment: Alignment.center,
                child: Image.asset(
                  "images/logo-app.png",
                  width: 70,
                  height: 70,
                ),
              ),
              const Icon(
                Icons.notification_add,
                size: 30,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildMainUI();
            } else if (snapshot.hasError) {
              return const Center(
                child:
                    Text("An error occurred: Check Your Internet Connection"),
              );
            } else {
              return buildMainUI();
            }
          },
        ),
      ),
      bottomNavigationBar: Footer(userData: userInfo ?? UserData()),
    );
  }

  Widget buildMainUI() {
    return Stack(
      children: [
        SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    HomeFirst(coinData, amount: amountApp, userData: userInfo),
                    Container(
                      width: MediaQuery.devicePixelRatioOf(context),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 30,
                            margin: const EdgeInsets.only(top: 10, bottom: 30),
                            child: items.length < 1
                                ? const Center(
                                    child: Text(
                                      "No Crypto Wallet Found",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = items[index];
                                      return WalletCard(
                                        item: item,
                                        index: index,
                                        coinData: coinData,
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
