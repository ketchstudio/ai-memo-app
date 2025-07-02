import 'package:ana_flutter/data/remote/memo_remote_datasource.dart';

import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    getIt.registerSingleton<MemoRemoteDataSource>(MemoRemoteDataSource());
  }
}
