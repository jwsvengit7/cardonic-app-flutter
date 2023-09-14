class Coin {
  final int coin_id;
  final String name;
  final String image;
  final double current_price;
  final double old_price;
  final bool activate;

  Coin({
    required this.coin_id,
    required this.name,
    required this.image,
    required this.current_price,
    required this.old_price,
    required this.activate,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      coin_id: json['coin_id'],
      name: json['name'],
      image: json['image'],
      current_price: json['current_price'].toDouble(),
      old_price: json['old_price'].toDouble(),
      activate: json['activate'],
    );
  }
}
