class WalletResponse {
  final double crypto_balance;
  final double card_balance;
  final double balance_amount;

  WalletResponse(
      {required this.crypto_balance,
      required this.card_balance,
      required this.balance_amount});

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
        card_balance: json['card_balance'] as double,
        crypto_balance: json['crypto_balance'] as double,
        balance_amount: json['balance_amount'] as double);
  }
}
