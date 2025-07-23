import 'package:ana_flutter/data/inmemory/folder_in_memory_datasource.dart';
import 'package:ana_flutter/data/inmemory/note_in_memory_datasource.dart';

import '../../../di/service_locator.dart';

class InMemoryModule {
  static Future<void> configureInMemoryModuleInjection() async {
    getIt.registerSingleton<FolderInMemoryDataSource>(FolderInMemoryDataSource());
    getIt.registerSingleton<NoteInMemoryDataSource>(NoteInMemoryDataSource());
  }
}
