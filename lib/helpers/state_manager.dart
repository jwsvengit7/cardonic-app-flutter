import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/Giftcard.dart';
import 'package:cardmonix/DTO/Response/User.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  Rx<WalletResponse?> balance = Rx<WalletResponse?>(null);
  RxList<Giftcard> giftcards = RxList<Giftcard>([]);
  RxList<Coin> coinList = RxList<Coin>([]);

  void setUser(User newUser) {
    user.value = newUser;
  }

  void setGiftcard(List<Giftcard> newGiftcard) {
    giftcards.value = newGiftcard;
  }

  void setCoinList(List<Coin> coin) {
    coinList.value = coin;
  }

  void setBalance(WalletResponse balance) {
    balance = balance;
  }

  void logout() {
    user.value = null;
  }
}
