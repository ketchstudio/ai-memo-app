import 'package:ana_flutter/data/inmemory/folder_in_memory_datasource.dart';
import 'package:ana_flutter/data/remote/supabase_auth_remote_datasource.dart';
import 'package:ana_flutter/data/repositories/supabase_auth_repository.dart';
import 'package:ana_flutter/data/repositories/supabase_memo_repository.dart';
import 'package:ana_flutter/domain/repositories/auth_repository.dart';
import 'package:ana_flutter/domain/repositories/folder_repository.dart';

import '../../../di/service_locator.dart';
import '../../../domain/repositories/memo_repository.dart';
import '../../datasource/note_remote_datasource.dart';
import '../../remote/supabase_folder_remote_datasource.dart';
import '../../repositories/default_folder_repository.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerSingleton<NoteRepository>(
      SupabaseNoteRepository(getIt<NoteRemoteDataSource>()),
    );

    getIt.registerSingleton<AuthRepository>(
      SupabaseAuthRepository(getIt<SupabaseAuthRemoteDataSource>()),
    );

    getIt.registerSingleton<FolderRepository>(
      DefaultFolderRepository(
        getIt<MemoryFolderDataSource>(),
        getIt<SupabaseRemoteFolderDataSource>(),
      ),
    );
  }
}
