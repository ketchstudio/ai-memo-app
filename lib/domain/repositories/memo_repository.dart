import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:result_dart/result_dart.dart';

import '../models/create_note_request.dart';

abstract class NoteRepository {
  Stream<List<Note>> observe();

  AsyncResultDart<List<Note>, AppError> getAll();

  AsyncResultDart<List<Note>, AppError> getByFolderId(String id);

  AsyncResultDart<Note, AppError> create(CreateNoteRequest body);

  AsyncResultDart<Nothing, AppError> delete(String id);

  AsyncResultDart<Nothing, AppError> refresh();
}
