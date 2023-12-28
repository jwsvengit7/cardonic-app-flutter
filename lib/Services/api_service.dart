import 'dart:convert';
import 'package:cardmonix/DTO/Request/Request.dart';
import 'package:cardmonix/DTO/Response/AccountInfoResponse.dart';
import 'package:cardmonix/DTO/Response/CoinsResponse.dart';
import 'package:cardmonix/DTO/Response/Giftcard.dart';
import 'package:cardmonix/DTO/Response/WalletResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardmonix/Helpers/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class APIService {
  final Dio _dio = Dio();

  APIService() {
    _dio.options.baseUrl = Constants.getBackendUrl();
  }

  Future<Response> createAccount({var email, var password, var username}) async {
    try {
      return await _dio.post(
        '/api/v1/Signup.php',
        data: jsonEncode(Request.createRequest(username, email, password)),
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create account: $e');
    }
  }

  Future<Response> verifyOtp({var email, var otp}) async {
    try {
      return await _dio.post(
        '/api/v1/Otp.php',
        data: jsonEncode(Request.verifyOtp(email, otp)),
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
   
      throw Exception('Failed to verify OTP: $e');
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
  try {
    final response = await _dio.get(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,tether,xrp,bitcoin-cash,litecoin',
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data; 
      List<Coin> coins = jsonData.map((data) => Coin.fromJson(data)).toList();
      return coins;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load data');
  }
}



Future<List<Giftcard>> fetchGiftcards(var userId) async {
  try {
    final response = await _dio.get(
      '/api/v1/viewcards.php',
      queryParameters: {'userId': userId}, 
    );

    final List<dynamic> jsonData = response.data['data'];
    if (jsonData.isNotEmpty) {
      List<Giftcard> giftcards = jsonData.map((data) => Giftcard.fromJson(data)).toList();
      return giftcards;
    } else {
      throw Exception('Failed to fetch gift cards: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load gift cards: $e');
  }
}


Future<Response> createGiftcard(var saveToken, var name, var amount) async {
  try {
    final response = await _dio.post(
      '/api/v1/giftcards/create-giftcard',
      options: Options(
        headers: {'Authorization': 'Bearer $saveToken'},
        contentType: Headers.jsonContentType,
      ),
      data: Request.createGiftcard(name, amount),
    );
    return response;
  } catch (e) {
    print('Error creating gift card: $e');
    throw Exception('Failed to create gift card: $e');
  }
}

Future<WalletResponse> getWallet(var userId) async {
  try {
    final response = await _dio.get(
      '/api/v1/GetUserDetails.php/$userId',
    );
    
    if (response.statusCode == 200) {
      final dynamic responseData = response.data;
      
      if (responseData is Map<String, dynamic> && responseData.containsKey('balance')) {
        final dynamic balanceData = responseData['balance'];
      
        
          final WalletResponse balance = WalletResponse.fromJson(balanceData);
       
          return balance;
        
      }
    }
    
    throw Exception('Failed to load wallet details: ${response.statusCode}');
  } catch (e) {
    print('Error fetching wallet details: $e');
    throw Exception('Failed to load wallet details: $e');
  }
}

Future<AccountInfoResponse> getAccount(var id) async {
  try {
    final response = await _dio.get(
      '/api/v1/getBankAccount.php/$id',
    );

    if (response.statusCode == 200) {
      final dynamic responseData = response.data;
      
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

    throw Exception('Failed to load account details: ${response.statusCode}');
  } catch (e) {
    print('Error loading account details: $e');
    throw Exception('Failed to load account details: $e');
  }
}

Future<List<String>> getCategory(String type) async {
  try {
    final response = await _dio.get(
      '/api/v1/category.php/$type',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data;
      List<String> data = responseData.map((item) => item.toString()).toList();

      return data;
    } else {
      throw Exception('Failed to load category details: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading category details: $e');
    throw Exception('Failed to load category details: $e');
  }
}

Future<Response> getAccountName(String accountNumber, String bankCode) async {
  try {
    final response = await _dio.get(
      'https://api.paystack.co/bank/resolve',
      queryParameters: Request.getAccountName(accountNumber, bankCode),
      options: Options(headers: {
        'Authorization': 'Bearer sk_test_652cb496246c20a1a51456bdf96c12485b37cf7c'
      }),
    );
    return response;
  } catch (e) {
    print('Error getting account name: $e');
    throw Exception('Failed to get account name: $e');
  }
}

Future<Response> saveAccount(
  int? userid,
  String accountNumber,
  String bankName,
  String accountName,
) async {
  try {
    final response = await _dio.post(
      '/api/v1/AddBankAccount.php/$userid',
      data: jsonEncode(Request.createBankAccount(accountNumber, bankName, accountName)),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return response;
  } catch (e) {
    print('Error saving account: $e');
    throw Exception('Failed to save account: $e');
  }
}


// DEPOSIT SERVICE
Future<Response> getDeposit(var saveToken, var userId) async {
  try {
    final response = await _dio.get(
      '/api/v1/deposit/get-deposit-byUser/$userId',
      options: Options(
        headers: {'Authorization': 'Bearer $saveToken'},
      ),
    );
    return response;
  } catch (e) {
    print('Error getting deposit: $e');
    throw Exception('Failed to get deposit: $e');
  }
}

Future<Response> getAllDeposit(var saveToken) async {
  try {
    final response = await _dio.get(
      '/api/v1/deposit/get-all-deposit',
      options: Options(
        headers: {'Authorization': 'Bearer $saveToken'},
      ),
    );
    return response;
  } catch (e) {
    print('Error getting all deposits: $e');
    throw Exception('Failed to get all deposits: $e');
  }
}

Future<Response> tradeCoin(String saveToken, var coin, var amount) async {
  try {
    final response = await _dio.post(
      '/api/v1/deposit/buy-coin',
      options: Options(
        headers: {
          'Authorization': 'Bearer $saveToken',
          'Content-Type': 'application/json',
        },
      ),
      data: Request.traderequest(amount, coin),
    );
    return response;
  } catch (e) {
    print('Error trading coin: $e');
    throw Exception('Failed to trade coin: $e');
  }
}


  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
