import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  /// Listen to raw Supabase session events
  Stream<Session?> authStateChanges();

  /// Get current raw Supabase session
  Session? getCurrentSession();

  /// Sign out
  Future<void> signOut();
}

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _client;

  SupabaseAuthRemoteDataSource(this._client);

  @override
  Stream<Session?> authStateChanges() =>
      _client.auth.onAuthStateChange.map((e) => e.session);

  @override
  Session? getCurrentSession() => _client.auth.currentSession;

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
