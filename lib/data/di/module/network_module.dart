import 'package:ana_flutter/data/remote/digital_ocean_file_remote_datarouce.dart';
import 'package:ana_flutter/data/remote/supabase_folder_remote_datasource.dart';
import 'package:ana_flutter/data/remote/supabase_note_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../di/service_locator.dart';
import '../../datasource/file_remote_datasource.dart';
import '../../datasource/note_remote_datasource.dart';
import '../../remote/supabase_auth_remote_datasource.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // Registering Supabase client
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
    getIt.registerSingleton<Dio>(Dio());

    // Registering remote data sources
    getIt.registerSingleton<NoteRemoteDataSource>(
      SupabaseNoteRemoteDataSource(getIt<SupabaseClient>()),
    );
    getIt.registerSingleton<SupabaseAuthRemoteDataSource>(
      SupabaseAuthRemoteDataSource(getIt<SupabaseClient>()),
    );
    getIt.registerSingleton<SupabaseRemoteFolderDataSource>(
      SupabaseRemoteFolderDataSource(getIt<SupabaseClient>()),
    );
    getIt.registerSingleton<FileRemoteDataSource>(
      DigitalOceanFileRemoteDataSource(getIt<Dio>()),
    );
  }
}
