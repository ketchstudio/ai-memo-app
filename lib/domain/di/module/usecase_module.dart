import 'package:ana_flutter/domain/usecase/memo/create_note_use_case.dart';

import '../../../di/service_locator.dart';
import '../../repositories/memo_repository.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    getIt.registerSingleton<InsertMemoUseCase>(
      InsertMemoUseCase(getIt<NoteRepository>()),
    );
  }
}
