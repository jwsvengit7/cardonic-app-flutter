class AccountInfoResponse {
  int id;
  int userId;
  String accountNumber;
  String accountName;
  String bank;

  AccountInfoResponse({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountName,
    required this.bank,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) {
    return AccountInfoResponse(
      id: json['id'] ?? 0,
      userId: json['userid'] ?? 0,
      accountNumber: json['accountNumber'] ?? '',
      accountName: json['accountName'] ?? '',
      bank: json['bank'] ?? '',
    );
  }
}
