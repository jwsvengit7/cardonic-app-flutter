import 'package:cardmonix/screen/User/dto/response/CoinsResponse.dart';
import 'package:cardmonix/screen/User/dto/response/Giftcard.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/User/coins/coins.dart';
import 'package:cardmonix/screen/User/footer.dart';
import 'package:cardmonix/screen/User/Drawers.dart';
import 'package:cardmonix/screen/User/dto/response/UserDetails.dart';
import 'package:cardmonix/service/api_service.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Coin> coinData = [];
  UserData? userInfo;
  List<Giftcard> giftcard = [];
  double amountApp = 0;

  Future<void> fetchGifcard() async {
    try {
      final savedToken = await APIService().getStoredToken();
      final response = await APIService().getAllGiftcard(savedToken);
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> content = data['data'];
      giftcard = content.map((coinJson) {
        return Giftcard(
          image: coinJson['image'],
          type: coinJson['type'],
          price: coinJson['price'],
        );
      }).toList();
      print(content);
      print(giftcard[0].image);
      setState(() {});
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
        setState(() {
          userInfo = UserData(
            id: userdetails['id'],
            email: userdetails['email'],
            user_name: userdetails['user_name'],
            phone: userdetails['phone'],
            dob: userdetails['dob'],
            profile: userdetails['profile'],
            role: userdetails['role'],
            balance: Balance(
              amount: BigInt.zero,
              balanceId: BigInt.zero,
              currency: "NGN",
            ),
          );
        });
        print(userdetails["balance"]);
        print(userdetails["balance"]["amount"]);
        amountApp = userdetails["balance"]["amount"];
        print(amountApp);
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGifcard();

    fetchData();
    fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawers(userData: userInfo ?? UserData(), card: giftcard),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildMainUI();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occurred: ${snapshot.error}"),
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
        Container(
          width: 400,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.menu, color: Colors.red, size: 35),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "images/logo-app.jpeg",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.notification_add,
                        size: 30,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    HomeFirst(coinData, amount: amountApp),
                    Container(
                      width: MediaQuery.devicePixelRatioOf(context),
                      height: 600,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Positioned(
                            top: 0,
                            child: Container(
                              alignment: Alignment.center,
                              width: 400,
                              height: 80,
                              child: Image.asset(
                                "images/logo-app.jpeg",
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
