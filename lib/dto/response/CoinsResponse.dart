class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'].toDouble(),
    );
  }
}
