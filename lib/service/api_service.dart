import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardmonix/helpers/constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<http.Response> createAccount(
      {var email, var password, var username}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.BASE_URL}/api/v1/auth/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"email": email, "password": password, "username": username}),
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
        Uri.parse("${Constants.BASE_URL}/api/v1/auth/otp_verify"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "otp": otp}),
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

  Future<http.Response> login({var email, var password}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.BASE_URL}/api/v1/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
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

  Future<http.Response> fetchCoins(int pageNo, int pageSize) {
    return http.get(
      Uri.parse(
          "${Constants.BASE_URL}/api/v1/user/veiw-coin?pageNo=$pageNo&pageSize=$pageSize"),
    );
  }

  Future<http.Response> fetchBalance(var savedToken) async {
    return http.get(
      Uri.parse("${Constants.BASE_URL}/api/v1/user/user-details"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<http.Response> getCoin(var savedToken, String coin) async {
    return http.get(
      Uri.parse("${Constants.BASE_URL}/api/v1/user/getcoinByName?coin=$coin"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<http.Response> getAllGiftcard(var saveToken) {
    return http.get(
      Uri.parse("${Constants.BASE_URL}/api/v1/giftcards/all-giftcard"),
      headers: {
        'Authorization': 'Beaer $saveToken',
      },
    );
  }

  Future<http.Response> getWallet(var saveToken) {
    return http
        .get(Uri.parse("${Constants.BASE_URL}/api/v1/user/wallets"), headers: {
      'Authorization': 'Beaer $saveToken',
    });
  }

  Future<http.Response> get_account(var saveToken) {
    return http.get(
        Uri.parse("${Constants.BASE_URL}/api/v1/account/get-my-account"),
        headers: {
          'Authorization': 'Beaer $saveToken',
        });
  }

  Future<http.Response> getAccountName(String accountNumber, String bankCode) {
    final Map<String, String> params = {
      'account_number': accountNumber,
      'bank_code': bankCode,
      'currency': 'NGN',
    };

    return http.get(
      Uri.parse("https://api.paystack.co/bank/resolve")
          .replace(queryParameters: params),
      headers: {
        'Authorization':
            'Bearer sk_test_652cb496246c20a1a51456bdf96c12485b37cf7c',
      },
    );
  }

  Future<http.Response> saveAccount(
      String accountNumber, String bankCode, String accountName) {
    return http.post(
        Uri.parse("${Constants.BASE_URL}/api/v1/account/saveAccount"),
        headers: {
          'Authorization': 'Beaer $getStoredToken()',
        },
        body: jsonEncode({
          'account_number': accountNumber,
          'bank_code': bankCode,
          'currency': 'NGN'
        }));
  }

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
