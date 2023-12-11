import 'package:cardmonix/utils/colors.dart';
import 'package:intl/intl.dart';

import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/Screens/User/Coins/CoinDetails.dart';
import 'package:cardmonix/Screens/User/Withdraw/withdraw.dart';
import 'package:cardmonix/utils/height.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFirst extends StatefulWidget {
  const HomeFirst({super.key});

  @override
  HomeFirstState createState() => HomeFirstState();
}

class HomeFirstState extends State<HomeFirst> {
  SizedBox spaceHeight = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: [
            Container(
              width: 390,
              height: 200,
              color: Colors.white70,
              padding: const EdgeInsets.only(top: 40),
              child: PageView.builder(
                itemCount: 3, // Three different balance sections
                itemBuilder: (BuildContext context, int index) {
                  return buildBalanceSection(authProvider, index);
                },
              ),
            ),
            // Positioned(
            //   bottom: 30,
            //   left: 10,
            //   right: 10,
            //   child: Container(
            //     width: 390,
            //     height: 200,
            //     margin: const EdgeInsets.symmetric(horizontal: 20),
            //     decoration: BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.circular(15),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.3),
            //           blurRadius: 15,
            //         ),
            //       ],
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             '\$${authProvider.balance?.balance_amount}',
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 28,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Utils.sizedBoxHeight(20),
            //           ElevatedButton(
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => Withdraw(),
            //                 ),
            //               );
            //             },
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.lightBlue,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(5),
            //               ),
            //             ),
            //             child: Container(
            //                 width: 110,
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 alignment: Alignment.center,
            //                 child: const Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     Icon(
            //                       Icons.balance,
            //                       size: 20,
            //                       color: Colors.white,
            //                     ),
            //                     Text(
            //                       "Withdraw",
            //                       style: TextStyle(
            //                         fontSize: 15,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 )),
            //           ),
            //           const SizedBox(height: 20),
            //           const Text(
            //             'Toatal Balance',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 20, top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: authProvider.coin!.map((value) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CoinDetailScreen(
                          coinName: value.name,
                          coinPrice: value.currentPrice,
                          coinImage: value.image,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    height: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.network(
                                value.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          value.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${value.currentPrice}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                          ),
                          child: const Text(
                            "Sell",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBalanceSection(AuthProvider authProvider, int index) {
    String balanceText = '';
    String typeBalance = '';
    final NumberFormat nairaFormat =
        NumberFormat.currency(locale: 'en_NG', symbol: '₦');

    if (index == 0) {
      balanceText = nairaFormat.format(authProvider.balance!.balance_amount);
      typeBalance = 'Total Balance';
    } else if (index == 1) {
      balanceText = nairaFormat.format(authProvider.balance!.card_balance);
      typeBalance = 'Total Balance';
      typeBalance = 'Giftcard Balance';
    } else if (index == 2) {
      balanceText = nairaFormat.format(authProvider.balance!.crypto_balance);
      typeBalance = 'Total Balance';
      typeBalance = 'Crypto Balance';
    }

    return Center(
      child: Container(
        width: 330,
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(40), // Adding border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                balanceText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Utils.sizedBoxHeight(20),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                typeBalance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
