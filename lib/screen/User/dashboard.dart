import 'package:cardmonix/dto/response/CoinsResponse.dart';
import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:cardmonix/dto/response/User.dart';
import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:cardmonix/helpers/provider.dart';
import 'package:cardmonix/helpers/state_manager.dart';
import 'package:cardmonix/screen/User/wallet.dart';
import 'package:cardmonix/screen/login_signup.dart';
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
import 'package:provider/provider.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<void> _redirect;
  late Future<void> _fetchDataFuture;
  late Future<void> _fetchCoin;
  late Future<void> _fetchBalance;
  late Future<void> _fetchApi;

  @override
  void initState() {
    super.initState();
    _redirect =redirect();
    _fetchDataFuture = fetchData();
    _fetchCoin = fetchGiftcards();
    _fetchBalance = getWallet();
    _fetchApi=fetchApi();


  }
  Future<void> redirect() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = authProvider.user;
  print(user!.token);
  if(user!.token==null || user!.token==""){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginSignupScreen()),
    );
  }


  }


  Future<void> fetchGiftcards() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final List<Giftcard> fetchedGiftcards = await APIService().fetchGiftcards(authProvider.user!.userid);
      authProvider.setGiftcards(fetchedGiftcards);
    } catch (e) {
      print('Error: $e');
      print(authProvider.user!.email);
    }
  }

  Future<void> getWallet() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print(authProvider.user!.userid);
    try {

      final WalletResponse balance = await APIService().getWallet(authProvider.user!.userid);
      authProvider.setBalance(balance);
      print("*****");
      print(balance);
    } catch (e) {
      print(e);
      print(authProvider.user!.email);
    }
  }

  Future<void> fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final List<Coin> conlist = await APIService().fetchData();
      authProvider.setCoinList(conlist);
      print(conlist);
    } catch (error) {
      print("Error occurred: $error");
      print(authProvider.user!.email);
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchApi() async {
    try {
      await Future.wait([
        fetchData(),
        fetchGiftcards(),
        getWallet(),

      ]);

    } catch (error) {
      print("Error occurred: $error");
      throw Exception('Error: $error');
    }
  }
    @override
    Widget build(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
          child: FutureBuilder<void>(
            future: fetchApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child:
                  Text("An error occurred: Check Your Internet Connection"),
                );
              } else {
                return buildMainUI(context);
              }
            },
          ),
        ),
        bottomNavigationBar: Footer(),
      );
    }




  Widget buildMainUI(BuildContext context) {
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
                      )
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
