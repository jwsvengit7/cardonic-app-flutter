import 'package:cardmonix/dto/response/CoinsResponse.dart';
import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:cardmonix/dto/response/User.dart';
import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:cardmonix/helpers/state_manager.dart';
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

import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

enum TypeCoin { ETH, USDT, BTC }

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController _authController = Get.put(AuthController());
  User? loggedInUser = Auth.auth().user.value;

  void fetchGiftcards() async {
    try {
      final List<Giftcard> fetchedGiftcards =
          await APIService().fetchGiftcards();
      _authController.setGiftcard(fetchedGiftcards);
    } catch (e) {
      print('Error: $e');
    }
  }

  void getWallet() async {
    try {
      final WalletResponse balance =
          await APIService().getWallet(loggedInUser?.userid);
      _authController.setBalance(balance);
      print(balance);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    try {
      final List<Coin> conlist = await APIService().fetchData();

      _authController.setCoinList(conlist);
      print(conlist);
    } catch (error) {
      print("Error occurred: $error");
      throw Exception('Error: $error');
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
    fetchGiftcards();
    fetchData();
    getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(child: Drawers()),
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
      bottomNavigationBar: Footer(),
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
                    HomeFirst(),
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
