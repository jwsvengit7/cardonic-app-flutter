class User {
  final String username;
  final int? userid;
  final String role;
  final String email;
  final String token;
  final int? phone;
  User(
      {required this.userid,
      required this.role,
      required this.username,
      required this.phone,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      role: json['role'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      token: json['token'],
    );
  }
}
