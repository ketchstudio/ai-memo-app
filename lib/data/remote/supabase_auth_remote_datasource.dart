import 'package:supabase_flutter/supabase_flutter.dart';

import 'domain/auth_remote_datasource.dart';

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

  @override
  bool isSignedIn() {
    return _client.auth.currentSession != null;
  }

  @override
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }
}
