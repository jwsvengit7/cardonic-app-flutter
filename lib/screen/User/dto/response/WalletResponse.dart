class WalletResponse {
  final BigInt walletId;
  final double wallet_amount;
  final double walletInUsd;
  final String coin;

  WalletResponse(
      {required this.walletId,
      required this.wallet_amount,
      required this.walletInUsd,
      required this.coin});

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
        walletId: json['walletId'],
        wallet_amount: json['wallet_amount'].toDouble(),
        walletInUsd: json['walletInUsd'].toDouble(),
        coin: json['coin']);
  }
}
