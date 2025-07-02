import 'package:ana_flutter/domain/repository/memo_repository.dart';
import 'package:ana_flutter/domain/usecase/memo/delete_memo_by_id_usecase.dart';
import 'package:ana_flutter/domain/usecase/memo/edit_memo_usecase.dart';
import 'package:ana_flutter/domain/usecase/memo/get_all_memo_usecase.dart';
import 'package:ana_flutter/domain/usecase/memo/insert_memo_usecase.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    getIt.registerSingleton<DeleteMemoByIdUseCase>(
      DeleteMemoByIdUseCase(getIt<MemoRepository>()),
    );

    getIt.registerSingleton<EditMemoUseCase>(
      EditMemoUseCase(getIt<MemoRepository>()),
    );

    getIt.registerSingleton<InsertMemoUseCase>(
      InsertMemoUseCase(getIt<MemoRepository>()),
    );

    getIt.registerSingleton<GetAllMemoUseCase>(
      GetAllMemoUseCase(getIt<MemoRepository>()),
    );
  }
}
