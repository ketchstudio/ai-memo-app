import 'package:ana_flutter/data/remote/memo_remote_datasource.dart';
import 'package:ana_flutter/data/remote/supabase_auth_remote_datasource.dart';
import 'package:ana_flutter/data/repositories/default_memo_repository.dart';
import 'package:ana_flutter/data/repositories/supabase_auth_repository.dart';
import 'package:ana_flutter/domain/repositories/auth_repository.dart';

import '../../../di/service_locator.dart';
import '../../../domain/repositories/memo_repository.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerSingleton<MemoRepository>(
      DefaultMemoRepository(getIt<MemoRemoteDataSource>()),
    );

    getIt.registerSingleton<AuthRepository>(
      SupabaseAuthRepository(getIt<SupabaseAuthRemoteDataSource>()),
    );
  }
}
