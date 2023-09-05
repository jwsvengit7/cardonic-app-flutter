import 'package:cardmonix/screen/User/dto/CoinsResponse.dart';
import 'package:cardmonix/screen/User/dto/UserDetails.dart';
import 'package:cardmonix/screen/User/giftcards/giftcardsItem.dart';
import 'package:cardmonix/screen/User/settings.dart';
import 'package:cardmonix/screen/Verification/otp_verification.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cardmonix/screen/User/coins/coins.dart';
import 'package:cardmonix/screen/User/footer.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String email = '';
  String user_name = '';
  String profile = '';
  String role = '';
  BigInt? amount = null;

  List<Coin> coinData = [];
  dynamic userInfo;

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
        print(coinData.length);
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
    print("Bearer " + savedToken!);

    try {
      final response = await APIService().fetchBalance(savedToken);
      print(savedToken);

      if (response.statusCode == 200) {
        final dynamic userDetailsJson = json.decode(response.body);

        print(userDetailsJson["data"]);
        final UserDetails userDetails = UserDetails.fromJson(userDetailsJson);
        final Balance balanceData = userDetails.data.balance;
        print(balanceData);
        print(balanceData.currency);

        // ignore: unnecessary_null_comparison
        if (balanceData != null) {
          amount = balanceData.amount;
        } else {
          amount = BigInt.two;
        }

        if (userDetails.data.email != null) {
          email = userDetails.data.email!;
        } else {
          email = '********';
        }

        setState(() {
          email = userDetails.data.email!;
          user_name = userDetails.data.user_name!;
          profile = userDetails.data.profile;
          role = userDetails.data.role;
          print(amount);
          print("****************************");
        });
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

    fetchData();
    fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 70, 41),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user_name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 70, 41),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Sell Giftcards'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Item()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: const Text('Exchange Coin'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Otp(email: "")),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
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
                            child:
                                Icon(Icons.menu, color: Colors.red, size: 35),
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
                        HomeFirst(coinData, amount: amount),
                        Container(
                          width: MediaQuery.devicePixelRatioOf(context),
                          height: 300,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
