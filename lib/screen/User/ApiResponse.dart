class ApiResponse<T> {
  T data;

  ApiResponse(this.data);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      json['data'] as T,
    );
  }
}
