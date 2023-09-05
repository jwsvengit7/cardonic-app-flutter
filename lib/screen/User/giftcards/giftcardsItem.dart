import 'package:cardmonix/screen/User/footer.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [], title: Text("APP")),
        body: Wrap(
          spacing: 15,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              alignment: Alignment.center,
              child: Image.asset(
                "images/logo-app.jpeg",
                width: 100,
                height: 100,
              ),
            ),
            Container(
              width: 120,
              height: 130,
              color: Colors.red,
            ),
            Container(
              width: 120,
              height: 130,
              color: Colors.red,
            ),
            Container(
              width: 120,
              height: 130,
              color: Colors.red,
            ),
            Container(
              width: 120,
              height: 130,
              color: Colors.red,
            ),
          ],
        ),
        bottomNavigationBar: Footer());
  }
}
