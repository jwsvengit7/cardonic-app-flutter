import 'package:cardmonix/utils/colors.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';

class RateCard extends StatefulWidget {
  RateCardState createState() => RateCardState();
}

class RateCardState extends State<RateCard> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController card = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController sub_category = TextEditingController();
  TextEditingController comment = TextEditingController();
  String cat = 'Iphone';

  List<String> categories = [
    'Iphone',
    'Amazon',
    'iPhone Samsung',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Material(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.transparent,
                  child: Ink(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 111, 101),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: SizedBox(
                      width: 350,
                      height: 90,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Sell Giftcards",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.orange,
                              ),
                              child: const Icon(Icons.card_giftcard,
                                  color: Colors.white),
                            )
                          ]),
                    ),
                  )),
            ),
            Utils.sizedBoxHeight(
              10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StaticWidget.buttonAction(
                    "Physical", colorUtilscardbg3, Colors.white),
                StaticWidget.buttonAction(
                    "Grade", colorUtilscardbg, colorUtilscardbg2),
              ],
            ),
            Utils.sizedBoxHeight(
              20,
            ),
            const Center(
              child: Text("Physical or E-code?"),
            ),
            Utils.sizedBoxHeight(20),
            Container(
              width: 350,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: card,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    Utils.sizedBoxHeight(16.0),
                    TextFormField(
                      controller: amount,
                      decoration: const InputDecoration(
                        labelText: 'Enter Gift Card Amount',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    Utils.sizedBoxHeight(24.0),
                    GestureDetector(
                      onTap: () {},
                      child: Material(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.transparent,
                          child: Ink(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 246, 111, 101),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Container(
                              width: 350,
                              height: 90,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "₦0.00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                  Text(
                                    'Rate - ₦245',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    Utils.sizedBoxHeight(20),
                    Center(
                      child: DropdownButtonFormField<String>(
                        value: cat,
                        onChanged: (newValue) {
                          setState(() {
                            cat = newValue!;
                          });
                        },
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaticWidget {
  static Widget buttonAction(String text, Color color, Color coloText) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(0), // Set a default borderRadius
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
              color: color,
              borderRadius: text == "Physical"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0))
                  : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
          child: Container(
            width: 175,
            height: 50,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: coloText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
