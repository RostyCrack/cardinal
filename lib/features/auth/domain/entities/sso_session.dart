class SsoSession {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final int? expiresIn;

  const SsoSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    this.expiresIn,
  });
}