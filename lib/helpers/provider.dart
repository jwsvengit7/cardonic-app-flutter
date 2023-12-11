import 'package:cardmonix/DTO/Response/AccountInfoResponse.dart';
import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/Giftcard.dart';
import 'package:cardmonix/DTO/Response/User.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  WalletResponse? _balance;
  List<Giftcard>? _giftcards;
  List<Coin>? _coin;
  List<String>? _category;
  List<String>? _subCategory;
  bool _isFetching = false;
  AccountInfoResponse? _account;

  User? get user => _user;
  List<Coin>? get coin => _coin;
  List<String>? get category => _category;
  List<String>? get subCategory => _subCategory;
  List<Giftcard>? get giftcards => _giftcards;
  WalletResponse? get balance => _balance;
  AccountInfoResponse? get account => _account;
  bool get isFetching => _isFetching;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setCategory(List<String> category) {
    _category = category;
    notifyListeners();
  }

  void setSubCategory(List<String> subCategory) {
    _subCategory = subCategory;
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

  void setAccount(AccountInfoResponse accountInfoResponse) {
    _account = accountInfoResponse;
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
