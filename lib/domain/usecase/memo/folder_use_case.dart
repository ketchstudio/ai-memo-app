import 'package:result_dart/result_dart.dart';

import '../../models/app_error.dart';
import '../../models/folder.dart';
import '../../repositories/folder_repository.dart';

// Get Folders as Stream (realtime)
class GetFoldersStreamUseCase {
  final FolderRepository repository;

  GetFoldersStreamUseCase(this.repository);

  Stream<ResultDart<List<Folder>, AppError>> call() {
    return repository.observe();
  }
}

// Create Folder
class CreateFolderUseCase {
  final FolderRepository repository;

  CreateFolderUseCase(this.repository);

  AsyncResultDart<Folder, AppError> call(String name) => repository.add(name);
}

// Edit Folder
class EditFolderUseCase {
  final FolderRepository repository;

  EditFolderUseCase(this.repository);

  AsyncResultDart<void, AppError> call(String id, String newName) =>
      repository.edit(id, newName);
}

// Remove Folder
class DeleteFolderUseCase {
  final FolderRepository repository;

  DeleteFolderUseCase(this.repository);

  AsyncResultDart<void, AppError> call(String id) => repository.deleteById(id);
}
