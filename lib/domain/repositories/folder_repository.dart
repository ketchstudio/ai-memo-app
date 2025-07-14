import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../models/folder.dart';

abstract class FolderRepository {
  Stream<ResultDart<List<Folder>, AppError>> observe();

  AsyncResultDart<Folder, AppError> add(String name);

  AsyncResultDart<Nothing, AppError> edit(String id, String newName);

  AsyncResultDart<Nothing, AppError> deleteById(String id);
}
