class Giftcard {
  final int id;
  final String name;
  final double amount;
  final double rate;
  final String category;
  final String type;
  final String subCategory;
  final String date;
  final String comment;

  Giftcard({
    required this.id,
    required this.name,
    required this.amount,
    required this.rate,
    required this.category,
    required this.type,
    required this.subCategory,
    required this.date,
    required this.comment,
  });

  factory Giftcard.fromJson(Map<String, dynamic> json) {
    return Giftcard(
      id: json['id'],
      name: json['name'],
      amount: json['amount'].toDouble(),
      rate: json['rate'].toDouble(),
      category: json['category'],
      type: json['type'],
      subCategory: json['sub_category'],
      date: json['date'],
      comment: json['comment'],
    );
  }
}
