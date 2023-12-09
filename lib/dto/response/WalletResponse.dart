class WalletResponse {
  final int crypto_balance;
  final int card_balance;
  final int balance_amount;

  WalletResponse(
      {required this.crypto_balance,
      required this.card_balance,
      required this.balance_amount});

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
        card_balance: json['card_balance'] as int,
        crypto_balance: json['crypto_balance'] as int,
        balance_amount: json['balance_amount'] as int);
  }
}
