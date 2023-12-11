import 'dart:convert';
import 'package:cardmonix/DTO/Request/Request.dart';
import 'package:cardmonix/DTO/Response/AccountInfoResponse.dart';
import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/Giftcard.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardmonix/Helpers/constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<http.Response> createAccount(
      {var email, var password, var username}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/Signup.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Request.createRequest(username, email, password)),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }

  Future<http.Response> verifyOtp({var email, var otp}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/Otp.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Request.verifyOtp(email, otp)),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      return http.Response('Error: $e', 500);
    }
  }

  Future<http.Response> login({var email, var password}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/Login.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }

  Future<List<Coin>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,tether,xrp,bitcoin-cash,litecoin'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Coin> coins = jsonData.map((data) => Coin.fromJson(data)).toList();
      return coins;
    } else {
      throw Exception('Failed to load data');
    }
  }

// COIN

  Future<http.Response> fetchUserDetails(var savedToken) async {
    return http.get(
      Uri.parse("${Constants.getBackendUrl()}/api/v1/user/user-details"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<http.Response> getCoin(var savedToken, String coin) async {
    return http.get(
      Uri.parse(
          "${Constants.getBackendUrl()}/api/v1/user/getcoinByName?coin=$coin"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<List<Giftcard>> fetchGiftcards(var userId) async {
    try {
      final response = await http.get(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/viewcards.php"),
      );

      final String responseBody = response.body;
      print(responseBody);
      if (responseBody.isNotEmpty) {
        final List<dynamic> jsonData = json.decode(responseBody)['data'];
        List<Giftcard> giftcards =
            jsonData.map((data) => Giftcard.fromJson(data)).toList();
        return giftcards;
      } else {
        throw Exception('Failed to fetch gift cards: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load gift cards');
    }
  }

  Future<http.Response> createGiftcard(var saveToken, var name, var amount) {
    return http.post(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/giftcards/create-giftcard"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        },
        body: jsonEncode(Request.createGiftcard(name, amount)));
  }

  Future<WalletResponse> getWallet(var userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/GetUserDetails.php/$userId"),
      );
      print(response);
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print(responseData);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('balance')) {
          final dynamic balanceData = responseData['balance'];
          if (balanceData is Map<String, dynamic>) {
            final WalletResponse balance = WalletResponse.fromJson(balanceData);
            return balance;
          }
        }
      }

      throw Exception('Failed to load wallet details');
    } catch (e) {
      print(e);
      throw Exception('Failed to load wallet details');
    }
  }

  // Account Details

  Future<AccountInfoResponse> getAccount(var id) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1//getBankAccount.php/$id"),
      );
      print(response);
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print(responseData);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message')) {
          final dynamic account = responseData['message'];
          if (account is Map<String, dynamic>) {
            final AccountInfoResponse accountInfoResponse =
                AccountInfoResponse.fromJson(account);
            return accountInfoResponse;
          }
        }
      }

      throw Exception('Failed to load account details');
    } catch (e) {
      print(e);
      throw Exception('Failed to load account details');
    }
  }

  Future<List<String>> getCategory(String type) async {
    try {
      final response = await http.get(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/category.php/$type"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<String> data =
            responseData.map((item) => item.toString()).toList();

        return data;
      } else {
        throw Exception(
            'Failed to load category details: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load category details');
    }
  }

  Future<http.Response> getAccountName(String accountNumber, String bankCode) {
    return http.get(
      Uri.parse("https://api.paystack.co/bank/resolve").replace(
          queryParameters: Request.getAccountName(accountNumber, bankCode)),
      headers: {
        'Authorization':
            'Bearer sk_test_652cb496246c20a1a51456bdf96c12485b37cf7c',
      },
    );
  }

  Future<http.Response> saveAccount(
    int? userid,
    String accountNumber,
    String bankName,
    String accountName,
  ) async {
    final Uri uri = Uri.parse(
        "${Constants.getBackendUrl()}/api/v1/AddBankAccount.php/$userid");

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          Request.createBankAccount(accountNumber, bankName, accountName)),
    );
    return response;
  }

// DEPOSIT SERVICE

  Future<http.Response> getdeposit(var saveToken, var userId) {
    return http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/deposit/get-deposit-byUser/${userId}"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  Future<http.Response> getAlldeposit(var saveToken) {
    return http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/deposit/get-all-deposit"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  Future<http.Response> tradeCoin(
      String saveToken, var coin, var amount) async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.getBackendUrl()}/api/v1/deposit/buy-coin"),
          headers: {
            'Authorization': 'Bearer $saveToken',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(Request.traderequest(amount, coin)));
      if (response.statusCode == 201) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      return http.Response('Error: $e', 500);
    }
  }

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
