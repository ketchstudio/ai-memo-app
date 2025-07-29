import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/repositories/note_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../models/app_error.dart';
import '../models/folder.dart';
import '../repositories/folder_repository.dart';

//Init Folders
class GetAllFoldersUseCase {
  final FolderRepository repository;

  GetAllFoldersUseCase(this.repository);

  AsyncResultDart<Nothing, AppError> call() =>
      repository.getAll().map((_) => Nothing.instance);
}

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
        await repository.update(id, newName);
        await noteRepository.updateFolderName(id, newName);
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
      await repository.delete(id);
      await memoRepository.deleteByFolderId(id);
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
    repository.refresh();
    noteRepository.refresh();
    return Nothing.instance;
  });
}
