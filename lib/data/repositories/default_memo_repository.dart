import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/result/result_ext.dart';
import '../../domain/models/create_note_request.dart';
import '../../domain/repositories/memo_repository.dart';
import '../remote/domain/note_remote_datasource.dart';

class DefaultNoteRepository implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  DefaultNoteRepository(this.remoteDataSource);

  @override
  AsyncResultDart<Nothing, AppError> createNote({
    required CreateNoteRequest body,
  }) {
    return runCatchingAsync(() => remoteDataSource.pushNote(body: body));
  }
}
