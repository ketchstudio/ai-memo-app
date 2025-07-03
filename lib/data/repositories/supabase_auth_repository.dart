import '../../domain/repositories/auth_repository.dart';
import '../remote/supabase_auth_remote_datasource.dart';

class SupabaseAuthRepository implements AuthRepository {
  final AuthRemoteDataSource remote;

  SupabaseAuthRepository(this.remote);

  @override
  Future<void> signInWithGoogle() => remote.signInWithGoogle();

  @override
  Future<void> signInWithApple() => remote.signInWithApple();

  @override
  Future<void> signOut() => remote.signOut();

  @override
  bool isSignedIn() => remote.isSignedIn();

  @override
  String? getCurrentUserId() => remote.getCurrentUser()?.id;
}
