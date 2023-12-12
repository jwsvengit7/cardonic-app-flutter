import 'package:cardmonix/DTO/Response/AccountInfoResponse.dart';
import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/Giftcard.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/Screens/User/Views/WidgetAppFreeCustom.dart';
import 'package:cardmonix/Screens/User/Views/balanceView.dart';
import 'package:cardmonix/Screens/User/Views/coins.dart';
import 'package:cardmonix/Screens/login_signup.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:cardmonix/utils/imageUtils.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/Screens/User/footer.dart';
import 'package:cardmonix/Screens/User/Drawers.dart';
import 'package:cardmonix/Services/api_service.dart';

import 'dart:async';

import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 @override
  void initState() {
    super.initState();
  
  }

  Future<void> redirect() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    print(authProvider.user!.token);
    if (authProvider.user!.token == "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginSignupScreen()),
      );
    }
  }

  Future<void> getCategory(String category) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final List<String> fetchCategory =
          await APIService().getCategory(category);
      print(fetchCategory);
      if (category == "category") {
        authProvider.setCategory(fetchCategory);
      }
      if (category == "sub_category") {
        authProvider.setSubCategory(fetchCategory);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getSubCategory(String category) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final List<String> fetchCategory =
          await APIService().getCategory(category);
      print(fetchCategory);

      authProvider.setSubCategory(fetchCategory);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchGiftcards() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final List<Giftcard> fetchedGiftcards =
          await APIService().fetchGiftcards(authProvider.user!.userid);
      authProvider.setGiftcards(fetchedGiftcards);
    } catch (e) {
      print('Error: $e');
     
    }
  }

  Future<void> getWallet() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print(authProvider.user!.userid);
    try {
      final WalletResponse balance =
          await APIService().getWallet(authProvider.user!.userid);
      authProvider.setBalance(balance);

      print(balance.balance_amount);
      
    } catch (e) {
     throw Exception('Error: $e');
    }
  }

  Future<void> getBanks() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final AccountInfoResponse accountInfoResponse =
          await APIService().getAccount(authProvider.user!.userid);
      authProvider.setAccount(accountInfoResponse);
      print(accountInfoResponse);
    } catch (error) {
    
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final List<Coin> conlist = await APIService().fetchData();
      authProvider.setCoinList(conlist);
 
    } catch (error) {
   
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchApi() async {
    try {
      await Future.wait([
        fetchData(),
        fetchGiftcards(),
        getWallet(),
        getBanks(),
        getSubCategory("sub_category"),
        getCategory("category"),
      ]);
    } catch (error) {
     
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  Drawer(child: Drawers()),
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
                  width: 50,
                  height: 50,
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
              return  Center(
                child:
                Center(child:
                
                Column(
                  children: [
                       Utils.sizedBoxHeight(30),
                   Image.asset(NO_INTERNET,width: 300),
                   Utils.sizedBoxHeight(10),
                  const  Text("Internet Issues Please Try Again")
                  ]),
                )
              );
            } else {
              return buildMainUI(context);
            }
          },
        ),
      ),
      bottomNavigationBar:  Footer(),
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
                    BalanceView(),
                    Utils.sizedBoxHeight(20),
                       const WidgetAppFreeCustom(text:"Sell Giftcard",text2:"This is right about it"),

                       const WidgetAppFreeCustom(text:"Sell Crypto",text2:"This is wrong about it"),
                    const HomeFirst(),
                    
                    Container(
                      width: MediaQuery.devicePixelRatioOf(context),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text("2")],
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
