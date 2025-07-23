import 'package:ana_flutter/domain/models/note.dart';

import '../../../domain/models/create_note_request.dart';

abstract class NoteRemoteDataSource {
  Future<List<Note>> getAll();

  Future<Note> create({required CreateNoteRequest body});

  Future<void> delete(String id);
}
