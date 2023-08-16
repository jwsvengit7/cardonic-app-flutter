class ApiResponse<T> {
  T data;

  ApiResponse(this.data);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      json['data'] as T,
    );
  }
}

class UserResponse {
  final String user_name;
  final String email;
  final String dob;
  final String profile;
  final String Role;

  UserResponse({
    required this.user_name,
    required this.dob,
    required this.profile,
    required this.email,
    required this.Role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user_name: json['user_name'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String,
      profile: json['profile'] as String,
      Role: json['Role'] as String,
    );
  }
}
