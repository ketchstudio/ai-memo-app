import 'package:ana_flutter/domain/usecase/memo/create_note_use_case.dart';
import 'package:ana_flutter/domain/usecase/memo/folder_use_case.dart';

import '../../../di/service_locator.dart';
import '../../repositories/folder_repository.dart';
import '../../repositories/memo_repository.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    getIt.registerSingleton<CreateNoteWithFolderUpdateUseCase>(
      CreateNoteWithFolderUpdateUseCase(
        getIt<NoteRepository>(),
        getIt<FolderRepository>(),
      ),
    );

    getIt.registerSingleton<CreateFolderUseCase>(
      CreateFolderUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<GetFoldersStreamUseCase>(
      GetFoldersStreamUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<EditFolderUseCase>(
      EditFolderUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<DeleteFolderUseCase>(
      DeleteFolderUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<RefreshFoldersUseCase>(
      RefreshFoldersUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<GetAllFoldersUseCase>(
      GetAllFoldersUseCase(getIt<FolderRepository>()),
    );
  }
}
