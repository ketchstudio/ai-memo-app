import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/repositories/memo_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../models/app_error.dart';
import '../../models/folder.dart';
import '../../repositories/folder_repository.dart';

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

  EditFolderUseCase(this.repository);

  AsyncResultDart<void, AppError> call(String id, String newName) =>
      repository.update(id, newName);
}

// Remove Folder
class DeleteFolderUseCase {
  final FolderRepository repository;

  DeleteFolderUseCase(this.repository);

  AsyncResultDart<void, AppError> call(String id) => repository.delete(id);
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
