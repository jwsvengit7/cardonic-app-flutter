class User {
  final String username;
  final int? userid;
  final String role;
  final String email;
  final String token;
  final String image;
  final int? phone;
  User(
      {required this.userid,
      required this.role,
      required this.username,
      required this.image,
      required this.phone,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      role: json['role'],
      username: json['username'],
      image: json['image'],
      phone: json['phone'],
      email: json['email'],
      token: json['token'],
    );
  }
}
