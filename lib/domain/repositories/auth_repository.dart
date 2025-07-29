import '../models/auth_session.dart';

/// Repository interface abstracting auth logic
abstract class AuthRepository {
  /// Stream of datasource-level session objects
  Stream<AuthSession?> get sessionStream;

  /// Current datasource session, or null if not authenticated
  AuthSession? get currentSession;

  String? get currentUserId;

  /// Signs out the user
  Future<void> signOut();
}
