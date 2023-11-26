import 'package:cardmonix/utils/colors.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';

class RateCard extends StatefulWidget {
  const RateCard({super.key});
  @override
  RateCardState createState() => RateCardState();
}

class RateCardState extends State<RateCard> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController card = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController comment = TextEditingController();
  String category = 'Select Category';

  String subCategory = "Select Sub-Category";

  List<String> categories = [
    'Select Category',
    'Iphone',
    'Amazon',
    'iPhone Samsung',
  ];
  List<String> subCategories = [
    'Select Sub-Category',
    'Pink',
    'Amazon',
    'iPhone Samsung',
  ];
  String pageName = "Giftcard Rate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            children: [
              Utils.sizedBoxHeight(20),
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
                  buttonAction("Physical", colorUtilscardbg3, Colors.white),
                  buttonAction("Grade", colorUtilscardbg, colorUtilscardbg2),
                ],
              ),
              Utils.sizedBoxHeight(
                20,
              ),
              const Center(
                child: Text("Physical or E-code?"),
              ),
              Utils.sizedBoxHeight(20),
              SizedBox(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Utils.sizedBoxHeight(20),
                      dropDownWidget(category, categories),
                      Utils.sizedBoxHeight(20),
                      dropDownWidget(subCategory, subCategories),
                      Utils.sizedBoxHeight(20),
                      TextFormField(
                        controller: amount,
                        decoration: const InputDecoration(
                          labelText: 'Enter Gift Card Amount',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      Utils.sizedBoxHeight(20),
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
                              child: const SizedBox(
                                width: 350,
                                height: 90,
                                child: Row(
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
                      TextField(
                        controller: _commentController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Type your comment here',
                        ),
                      ),
                      Utils.sizedBoxHeight(10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonAction(String text, Color color, Color coloText) {
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
          child: SizedBox(
            width: 175.0,
            height: 50.0,
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

  Widget dropDownWidget(String category, List<String> categories) {
    return Center(
      child: SizedBox(
        child: DropdownButtonFormField<String>(
          value: category,
          onChanged: (newValue) {
            setState(() {
              category = newValue!;
            });
          },
          items: categories.map((String categoryValue) {
            return DropdownMenuItem<String>(
              value: categoryValue,
              child: Text(categoryValue),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: "Select Category",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
