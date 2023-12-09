import 'package:cardmonix/dto/response/CoinsResponse.dart';
import 'package:cardmonix/dto/response/Giftcard.dart';
import 'package:cardmonix/dto/response/User.dart';
import 'package:cardmonix/dto/response/WalletResponse.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  WalletResponse? _balance;
  List<Giftcard>? _giftcards;
  List<Coin>? _coin;
  bool _isFetching = false;

  User? get user => _user;
  List<Coin>? get coin => _coin;
  List<Giftcard>? get giftcards => _giftcards;
  WalletResponse? get balance => _balance;
  bool get isFetching => _isFetching;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setGiftcards(List<Giftcard> newGiftcards) {
    _giftcards = newGiftcards;
    notifyListeners();
  }

  void setCoinList(List<Coin> coins) {
    _coin = coins;
    notifyListeners();
  }

  void setBalance(WalletResponse newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  void setIsFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }
}
