import 'dart:async';

import '../../domain/models/folder.dart';

class FolderInMemoryDataSource {
  final _controller = StreamController<List<Folder>>.broadcast();
  final List<Folder> _folders = [];

  Stream<List<Folder>> observe() => _controller.stream;

  Future<List<Folder>> getAll() async => List.unmodifiable(_folders);

  Future<Folder> create(Folder folder) async {
    _folders.add(folder);
    _controller.add(List.unmodifiable(_folders));
    return folder;
  }

  Future<void> update(String id, String newName) async {
    final idx = _folders.indexWhere((f) => f.id == id);
    if (idx == -1) return;
    _folders[idx] = _folders[idx].copyWith(name: newName);
    _controller.add(List.unmodifiable(_folders));
  }

  Future<void> delete(String id) async {
    _folders.removeWhere((f) => f.id == id);
    _controller.add(List.unmodifiable(_folders));
  }

  Future<void> setAll(List<Folder> folders) async {
    print('Setting folders: ${folders.length}');
    _folders
      ..clear()
      ..addAll(folders);
    _controller.add(List.unmodifiable(_folders));
  }
}

extension FolderNoteCountOps on FolderInMemoryDataSource {
  void incrementNoteCount(String folderId) {
    final idx = _folders.indexWhere((f) => f.id == folderId);
    if (idx == -1) return;
    final f = _folders[idx];
    _folders[idx] = f.copyWith(totalNotes: f.totalNotes + 1);
    _controller.add(List.unmodifiable(_folders));
  }
  void decrementNoteCount(String folderId) {
    final idx = _folders.indexWhere((f) => f.id == folderId);
    if (idx == -1) return;
    final f = _folders[idx];
    _folders[idx] = f.copyWith(totalNotes: f.totalNotes - 1);
    _controller.add(List.unmodifiable(_folders));
  }
}

