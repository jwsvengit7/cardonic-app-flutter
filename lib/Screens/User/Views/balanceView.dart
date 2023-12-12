import 'package:cardmonix/Helpers/provider.dart';
import 'package:cardmonix/utils/colors.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BalanceView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
        final authProvider = Provider.of<AuthProvider>(context, listen: false);

   return Stack(
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