import 'package:ana_flutter/data/remote/memo_remote_datasource.dart';
import 'package:ana_flutter/data/repository/default_memo_repository.dart';
import 'package:ana_flutter/domain/repository/memo_repository.dart';

import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerSingleton<MemoRepository>(
      DefaultMemoRepository(getIt<MemoRemoteDataSource>()),
    );
  }
}
