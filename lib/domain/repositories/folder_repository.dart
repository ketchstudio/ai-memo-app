import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../models/folder.dart';

abstract class FolderRepository {
  Stream<List<Folder>> observe();

  AsyncResultDart<List<Folder>, AppError> getAll();

  AsyncResultDart<Folder, AppError> create(String name);

  AsyncResultDart<Nothing, AppError> update(String id, String newName);

  AsyncResultDart<Nothing, AppError> delete(String id);

  AsyncResultDart<Nothing, AppError> refresh();

  AsyncResultDart<Nothing, AppError> incrementNoteCount(String folderId);

  AsyncResultDart<Nothing, AppError> decrementNoteCount(String folderId);
}
