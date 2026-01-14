class GetTokenWsAuthResponse {
  final String token;
  final String message;
  final String username;

  GetTokenWsAuthResponse({required this.username, required this.message, required this.token});

  factory GetTokenWsAuthResponse.fromJson(Map<String, dynamic> json) {
    return GetTokenWsAuthResponse(
      token: json['token'],
      username: json['username'],
      message: json['message'],
    );
  }
}