/// AuthSession entity representing an authenticated session
class AuthSession {
  const AuthSession({
    required this.userId,
    required this.profilePicture,
    required this.token,
    required this.refreshToken,
  });

  final String userId;
  final String token;
  final String refreshToken;
  final String profilePicture;

  /// Check if session has a refresh token
  bool get canRefresh => refreshToken.isNotEmpty;
}
