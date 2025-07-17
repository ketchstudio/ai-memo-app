import 'package:ana_flutter/data/inmemory/folder_in_memory_datasource.dart';

import '../../../di/service_locator.dart';

class InMemoryModule {
  static Future<void> configureInMemoryModuleInjection() async {
    getIt.registerSingleton<MemoryFolderDataSource>(MemoryFolderDataSource());
  }
}
