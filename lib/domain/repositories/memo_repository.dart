import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../models/create_note_request.dart';

abstract class NoteRepository {
  AsyncResultDart<Nothing, AppError> createNote({
    required CreateNoteRequest body,
  });
}
