import 'package:ana_flutter/domain/usecase/folder_use_case.dart';
import 'package:ana_flutter/domain/usecase/note_use_case.dart';

import '../../../di/service_locator.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/file_repository.dart';
import '../../repositories/folder_repository.dart';
import '../../repositories/note_repository.dart';
import '../../usecase/file_usecase.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // Note Use Cases
    getIt.registerSingleton<CreateNoteWithFolderUpdateUseCase>(
      CreateNoteWithFolderUpdateUseCase(
        getIt<NoteRepository>(),
        getIt<FolderRepository>(),
      ),
    );

    getIt.registerSingleton<DeleteNoteWithFolderUpdateUseCase>(
      DeleteNoteWithFolderUpdateUseCase(
        getIt<NoteRepository>(),
        getIt<FolderRepository>(),
      ),
    );

    getIt.registerSingleton<RefreshNotesWithFolderUpdateUseCase>(
      RefreshNotesWithFolderUpdateUseCase(getIt<NoteRepository>()),
    );

    getIt.registerSingleton<GetAllNotesUseCase>(
      GetAllNotesUseCase(getIt<NoteRepository>()),
    );

    getIt.registerSingleton<GetAllNotesUseCaseById>(
      GetAllNotesUseCaseById(getIt<NoteRepository>()),
    );

    getIt.registerSingleton<GetNotesStreamUseCase>(
      GetNotesStreamUseCase(getIt<NoteRepository>()),
    );

    //Folder Use Cases
    getIt.registerSingleton<CreateFolderUseCase>(
      CreateFolderUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<GetFoldersStreamUseCase>(
      GetFoldersStreamUseCase(getIt<FolderRepository>()),
    );

    getIt.registerSingleton<EditFolderUseCase>(
      EditFolderUseCase(getIt<FolderRepository>(), getIt<NoteRepository>()),
    );

    getIt.registerSingleton<DeleteFolderUseCase>(
      DeleteFolderUseCase(getIt<FolderRepository>(), getIt<NoteRepository>()),
    );

    getIt.registerSingleton<RefreshFoldersUseCase>(
      RefreshFoldersUseCase(getIt<FolderRepository>(), getIt<NoteRepository>()),
    );

    getIt.registerSingleton<GetAllFoldersUseCase>(
      GetAllFoldersUseCase(getIt<FolderRepository>()),
    );

    //File Use Cases
    getIt.registerSingleton<UploadFileUseCase>(
      UploadFileUseCase(
        getIt<FileRepository>(),
        getIt<NoteRepository>(),
        getIt<AuthRepository>(),
      ),
    );
  }
}
