import 'package:cardmonix/Helpers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildContactInfoCard(
            "Name",
            authProvider.user!.username,
          ),
          buildContactInfoCard(
            "Email",
            authProvider.user!.email,
          ),
          buildContactInfoCard(
            "Phone",
            authProvider.user!.phone.toString(),
          ),
          buildAccountDetailsCard(
            "Account Details",
            "Account ID: 123456789",
            "Member since: January 2022",
          ),
        ],
      ),
    );
  }

  Widget buildContactInfoCard(String title, String content) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(content),
      ),
    );
  }

  Widget buildAccountDetailsCard(
      String title, String accountID, String memberSince) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ),
          ListTile(
            title: const Text("Bank Name",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              authProvider.account!.bank,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Account Name",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              authProvider.account!.accountName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Account Number",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              authProvider.account!.accountNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
