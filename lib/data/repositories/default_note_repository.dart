import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/result/result_ext.dart';
import '../../domain/models/create_note_request.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasource/note_remote_datasource.dart';
import '../inmemory/note_in_memory_datasource.dart';

class DefaultNoteRepository implements NoteRepository {
  final NoteRemoteDataSource _remote;
  final NoteInMemoryDataSource _local;

  DefaultNoteRepository(this._remote, this._local);

  @override
  Stream<List<Note>> observe() => _local.observe();

  @override
  AsyncResultDart<List<Note>, AppError> getAll() => runCatchingAsync(() async {
    final localNotes = await _local.getAll();
    if (localNotes.isNotEmpty) {
      return localNotes;
    } else {
      final remoteNotes = await _remote.getAll();
      await _local.setAll(remoteNotes);
      return remoteNotes;
    }
  });

  @override
  AsyncResultDart<List<Note>, AppError> getByFolderId(String folderId) =>
      runCatchingAsync(() async => _local.getByFolderId(folderId));

  @override
  AsyncResultDart<Nothing, AppError> updateFolderName(
    String id,
    String newName,
  ) => runCatchingAsync(() async {
    await _local.updateFolderName(id, newName);
    return Nothing.instance;
  });

  @override
  AsyncResultDart<Note, AppError> create(CreateNoteRequest body) async {
    return runCatchingAsync(() async {
      final remoteNote = await _remote.create(body: body);
      await _local.create(remoteNote);
      return remoteNote;
    });
  }

  @override
  AsyncResultDart<Nothing, AppError> delete(String id) =>
      runCatchingAsync(() async {
        await _remote.delete(id);
        await _local.delete(id);
        return Nothing.instance;
      });

  @override
  AsyncResultDart<Nothing, AppError> refresh() {
    return runCatchingAsync(() async {
      _local.setAll([]); // Clear local cache before refreshing
      final remoteNotes = await _remote.getAll();
      _local.setAll(remoteNotes);
      return Nothing.instance;
    });
  }

  @override
  AsyncResultDart<Nothing, AppError> deleteByFolderId(String id) {
    return runCatchingAsync(() async {
      await _local.deleteByFolderId(id);
      return Nothing.instance;
    });
  }
}
