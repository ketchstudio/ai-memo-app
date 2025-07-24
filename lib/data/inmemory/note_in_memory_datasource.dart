import 'dart:async';

import '../../domain/models/note.dart';

class NoteInMemoryDataSource {
  final _controller = StreamController<List<Note>>.broadcast();
  final List<Note> _notes = [];

  Stream<List<Note>> observe() => _controller.stream;

  Future<List<Note>> getAll() async => List.unmodifiable(_notes);

  Future<List<Note>> getByFolderId(String folderId) async =>
      _notes.where((note) => note.folderId == folderId).toList();

  Future<void> updateFolderName(String id, String newName) async {
    final newNotes = _notes.map((note) {
      if (note.folderId == id) {
        return note.copyWith(folderName: newName);
      }
      return note;
    }).toList();
    _notes
      ..clear()
      ..addAll(newNotes);
    _controller.add(List.unmodifiable(_notes));
  }

  Future<Note> create(Note note) async {
    // insert at index 0 so newest notes appear first
    _notes.insert(0, note);
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

  Future<void> deleteByFolderId(String folderId) async {
    _notes.removeWhere((note) => note.folderId == folderId);
    _controller.add(List.unmodifiable(_notes));
  }
}
