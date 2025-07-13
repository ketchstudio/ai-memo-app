import 'package:ana_flutter/core/result/result_ext.dart';

import '../../../domain/models/create_note_request.dart';

abstract class NoteRemoteDataSource {
  Future<Nothing> pushNote({
    required CreateNoteRequest body,
  });
}
