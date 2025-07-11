import '../models/auth_session.dart';

/// Repository interface abstracting auth logic
abstract class AuthRepository {
  /// Stream of domain-level session objects
  Stream<AuthSession?> get sessionStream;

  /// Current domain session, or null if not authenticated
  AuthSession? get currentSession;

  /// Signs out the user
  Future<void> signOut();
}
