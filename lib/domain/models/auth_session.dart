class AuthSession {
  final String accessToken;
  final int expiresAt;

  AuthSession({required this.accessToken, required this.expiresAt});
}

/// Supported OAuth providers in domain
enum AuthProviderType { google, apple }
