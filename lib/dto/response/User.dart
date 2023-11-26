class User {
  final String username;
  final int? userid;
  final String role;
  final String email;
  final String token;
  User(
      {required this.userid,
      required this.role,
      required this.username,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      role: json['role'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}
