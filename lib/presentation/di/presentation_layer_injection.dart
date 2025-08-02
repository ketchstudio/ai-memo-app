import '../../di/service_locator.dart';
import 'popup/ui_service.dart';

class PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    getIt.registerLazySingleton<UiService>(() => UiServiceImpl());
  }
}
