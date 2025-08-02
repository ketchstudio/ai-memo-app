import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/repositories/note_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../models/app_error.dart';
import '../models/folder.dart';
import '../repositories/folder_repository.dart';

// Get Folders as Stream (realtime)
class GetFoldersStreamUseCase {
  final FolderRepository repository;

  GetFoldersStreamUseCase(this.repository);

  Stream<List<Folder>> call() => repository.observe();
}

// Create Folder
class CreateFolderUseCase {
  final FolderRepository repository;

  CreateFolderUseCase(this.repository);

  AsyncResultDart<Folder, AppError> call(String name) =>
      repository.create(name);
}

// Edit Folder
class EditFolderUseCase {
  final FolderRepository repository;
  final NoteRepository noteRepository;

  EditFolderUseCase(this.repository, this.noteRepository);

  AsyncResultDart<void, AppError> call(String id, String newName) =>
      runCatchingAsync(() async {
        await repository.update(id, newName).getOrThrow();
        await noteRepository.updateFolderName(id, newName).getOrThrow();
        return Nothing.instance;
      });
}

// Remove Folder
class DeleteFolderUseCase {
  final FolderRepository repository;
  final NoteRepository memoRepository;

  DeleteFolderUseCase(this.repository, this.memoRepository);

  AsyncResultDart<void, AppError> call(String id) {
    return runCatchingAsync(() async {
      await repository.delete(id).getOrThrow();
      await memoRepository.deleteByFolderId(id).getOrThrow();
      return Nothing.instance;
    });
  }
}

// Refresh Folders
class RefreshFoldersUseCase {
  final FolderRepository repository;
  final NoteRepository noteRepository;

  RefreshFoldersUseCase(this.repository, this.noteRepository);

  AsyncResultDart<void, AppError> call() => runCatchingAsync(() async {
    await repository.refresh().getOrThrow();
    await noteRepository.refresh().getOrThrow();
    return Nothing.instance;
  });
}
