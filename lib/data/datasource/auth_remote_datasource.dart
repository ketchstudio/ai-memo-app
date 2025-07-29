import 'package:supabase_auth_ui/supabase_auth_ui.dart';

abstract class AuthRemoteDataSource {
  Stream<Session?> authStateChanges();

  Session? getCurrentSession();

  Future<void> signOut();

  bool isSignedIn();

  User? getCurrentUser();

  String? get currentUserId;
}
