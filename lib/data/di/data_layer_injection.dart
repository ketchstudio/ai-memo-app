import 'package:ana_flutter/data/di/module/in_memory_module.dart';

import 'module/network_module.dart';
import 'module/repository_module.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await InMemoryModule.configureInMemoryModuleInjection();
    await NetworkModule.configureNetworkModuleInjection();
    await RepositoryModule.configureRepositoryModuleInjection();
  }
}
