import 'package:flutter/material.dart';

class Giftcards extends StatelessWidget {
  SizedBox sizedBox = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Your Giftcards"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Giftcard Type:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBox,
            DropdownButton<String>(
              items: <String>['Amazon', 'iTunes', 'Google Play', 'Other']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
              hint: Text("Select a Giftcard Type"),
            ),
            sizedBox,
            const Text(
              "Enter Giftcard Amount:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBox,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBox,
            const Text(
              "Upload Giftcard Image:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBox,
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.cloud_upload),
              label: const Text("Upload Image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            sizedBox,
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sell Giftcard"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
