import 'dart:async';

import '../../domain/models/note.dart';

class NoteInMemoryDataSource {
  final _controller = StreamController<List<Note>>.broadcast();
  final List<Note> _notes = [];

  Stream<List<Note>> observe() => _controller.stream;

  Future<List<Note>> getAll() async => List.unmodifiable(_notes);

  Future<List<Note>> getByFolderId(String folderId) async =>
      _notes.where((note) => note.folderId == folderId).toList();

  Future<Note> create(Note note) async {
    _notes.add(note);
    _controller.add(List.unmodifiable(_notes));
    return note;
  }

  Future<void> delete(String id) async {
    _notes.removeWhere((f) => f.id == id);
    _controller.add(List.unmodifiable(_notes));
  }

  Future<void> setAll(List<Note> notes) async {
    _notes
      ..clear()
      ..addAll(notes);
    _controller.add(List.unmodifiable(_notes));
  }
}
