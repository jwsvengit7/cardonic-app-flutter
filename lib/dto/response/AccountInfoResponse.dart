class AccountInfoResponse {
  final String accountName;
  final String accountNumber;
  final String bank;
  final int userid;

  AccountInfoResponse({
    required this.bank,
    required this.accountNumber,
    required this.accountName,
    required this.userid,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) {
    return AccountInfoResponse(
      accountNumber: json['accountNumber'],
      bank: json['bank'],
      accountName: json['accountName'],
      userid: json['userid'],
    );
  }
}

class AccountInfo {
  final String accountNumber;
  final String accountName;
  final String bankName;

  AccountInfo({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      accountNumber: json['account_number'],
      accountName: json['account_name'],
      bankName: json['bankName'],
    );
  }
}
