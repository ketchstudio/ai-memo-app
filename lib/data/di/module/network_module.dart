import 'package:ana_flutter/data/remote/memo_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../di/service_locator.dart';
import '../../remote/supabase_auth_remote_datasource.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // Registering Supabase client
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

    // Registering remote data sources
    getIt.registerSingleton<MemoRemoteDataSource>(MemoRemoteDataSource());
    getIt.registerSingleton<SupabaseAuthRemoteDataSource>(
      SupabaseAuthRemoteDataSource(getIt<SupabaseClient>()),
    );
  }
}
