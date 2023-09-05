import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Bank Account"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.account_balance,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                buildInputField("Account Holder's Name", "John Doe"),
                SizedBox(
                  height: 20,
                ),
                buildInputField("Bank Name", "Bank of America"),
                SizedBox(
                  height: 20,
                ),
                buildInputField("Account Number", "1234 5678 9012 3456"),
                SizedBox(
                  height: 20,
                ),
                buildInputField("Routing Number", "987654321"),
                SizedBox(
                  height: 20,
                ),
                _buildSaveButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String labelText, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
        backgroundColor: Colors.blue,
      ),
    );
  }
}
