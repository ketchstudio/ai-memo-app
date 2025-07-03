import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<void> signInWithGoogle();

  Future<void> signInWithApple();

  Future<void> signOut();

  bool isSignedIn();

  User? getCurrentUser();
}

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _client;

  SupabaseAuthRemoteDataSource(this._client);

  @override
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.ketchsoft.ana.dev://login-callback/',
    );
  }

  @override
  Future<void> signInWithApple() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'com.ketchsoft.ana.dev://login-callback/',
    );
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  bool isSignedIn() {
    return _client.auth.currentSession != null;
  }

  @override
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }
}
