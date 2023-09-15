import 'dart:convert';
import 'package:cardmonix/screen/User/dto/response/Bank.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final banks = <Bank>[];
  Bank? selectedBank;
  String accountName = '';
  bool isFetchingAccountName = false;
  bool isSaveButtonDisabled = true;

  final accountNumberController = TextEditingController();
  SizedBox sizedBox = SizedBox(height: 20);

  @override
  void initState() {
    super.initState();
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.paystack.co/bank'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final bankData = data['data'];

        setState(() {
          banks.addAll(bankData.map<Bank>((bankJson) {
            return Bank(
              name: bankJson['name'],
              code: bankJson['code'],
            );
          }));
        });
      } else {
        print('Failed to fetch banks');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    super.dispose();
  }

  void _saveAccount() {
    print(accountName);
    print(accountNumberController.text);
    print(selectedBank!.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bank Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox,
                Image.asset("images/account.png"),
                sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: DropdownButtonFormField<Bank>(
                        value: selectedBank,
                        decoration: const InputDecoration(
                          labelText: 'Select a bank',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: banks.map((bank) {
                          return DropdownMenuItem<Bank>(
                            value: bank,
                            child: SizedBox(
                              width: 300,
                              child: Text('${bank.name}'),
                            ),
                          );
                        }).toList(),
                        onChanged: (Bank? value) {
                          setState(() {
                            selectedBank = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                sizedBox,
                TextFormField(
                  controller: accountNumberController,
                  onChanged: onAccountNumberChanged,
                  decoration: const InputDecoration(
                    labelText: 'Account Number',
                    border: OutlineInputBorder(),
                    hintText: 'Enter account number',
                  ),
                ),
                sizedBox,
                if (isFetchingAccountName)
                  CircularProgressIndicator()
                else if (accountName.isNotEmpty)
                  Text(
                    "Account Name: $accountName",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                sizedBox,
                buildSaveButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onAccountNumberChanged(String value) {
    setState(() {
      accountName = '';
      isFetchingAccountName = false;
      isSaveButtonDisabled = true;
    });

    if (value.length == 10) {
      fetchAccountName(value);
    }
  }

  Future<void> fetchAccountName(String accountNumber) async {
    if (selectedBank == null) {
      return;
    }

    final bankCode = selectedBank!.code;

    try {
      setState(() {
        isFetchingAccountName = true;
      });

      final response =
          await APIService().getAccountName(accountNumber, bankCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final accountNameResponse = data['data']['account_name'] ?? 'NOT FOUND';

        setState(() {
          accountName = accountNameResponse;
          isFetchingAccountName = false;
          isSaveButtonDisabled = false;
        });
      } else {
        setState(() {
          accountName = 'NOT FOUND';
          isFetchingAccountName = false;
          isSaveButtonDisabled = true;
        });
        print("Failed to fetch account name");
      }
    } catch (e) {
      setState(() {
        isFetchingAccountName = false;
        isSaveButtonDisabled = true;
      });
      print(e);
    }
  }

  Widget buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isSaveButtonDisabled ? null : _saveAccount,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          'Save Changes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: isSaveButtonDisabled ? Colors.grey : Colors.blue,
      ),
    );
  }
}
