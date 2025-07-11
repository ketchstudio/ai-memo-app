import '../../domain/models/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../remote/supabase_auth_remote_datasource.dart';

class SupabaseAuthRepository implements AuthRepository {
  final AuthRemoteDataSource _remote;

  SupabaseAuthRepository(this._remote);

  @override
  Stream<AuthSession?> get sessionStream => _remote.authStateChanges().map((
    sup,
  ) {
    if (sup == null) return null;
    return AuthSession(accessToken: sup.accessToken, expiresAt: sup.expiresAt!);
  });

  @override
  AuthSession? get currentSession {
    final sup = _remote.getCurrentSession();
    if (sup == null) return null;
    return AuthSession(accessToken: sup.accessToken, expiresAt: sup.expiresAt!);
  }

  @override
  Future<void> signOut() async {
    return _remote.signOut();
  }
}
