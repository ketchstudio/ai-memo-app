// lib/datasource/usecases/note_folder_usecases.dart

import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:ana_flutter/domain/repositories/folder_repository.dart';
import 'package:ana_flutter/domain/repositories/note_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/result/result_ext.dart';

class GetAllNotesUseCase {
  final NoteRepository _noteRepo;

  GetAllNotesUseCase(this._noteRepo);

  /// Fetches all notes.
  AsyncResultDart<List<Note>, AppError> call() => _noteRepo.getAll();
}

class GetAllNotesUseCaseById {
  final NoteRepository _noteRepo;

  GetAllNotesUseCaseById(this._noteRepo);

  /// Fetches all notes.
  AsyncResultDart<List<Note>, AppError> call(String folderId) =>
      _noteRepo.getByFolderId(folderId);
}

// Get Notes as Stream (realtime)
class GetNotesStreamUseCase {
  final NoteRepository repository;

  GetNotesStreamUseCase(this.repository);

  Stream<List<Note>> call() => repository.observe();
}

class CreateNoteWithFolderUpdateUseCase {
  final NoteRepository _noteRepo;
  final FolderRepository _folderRepo;

  CreateNoteWithFolderUpdateUseCase(this._noteRepo, this._folderRepo);

  /// Creates the note, then bumps the folder's totalNotes count.
  AsyncResultDart<Nothing, AppError> call(CreateNoteRequest params) =>
      runCatchingAsync(() async {
        await _noteRepo.create(params).getOrThrow();
        final folderId = params.folderId;
        if (folderId != null) {
          await _folderRepo.incrementNoteCount(folderId).getOrThrow();
        }
        return Nothing.instance;
      });
}

class DeleteNoteWithFolderUpdateUseCase {
  final NoteRepository _noteRepo;
  final FolderRepository _folderRepo;

  DeleteNoteWithFolderUpdateUseCase(this._noteRepo, this._folderRepo);

  /// Deletes the note, then decrements the folder's totalNotes count.
  AsyncResultDart<Nothing, AppError> call(String noteId, String? folderId) =>
      runCatchingAsync(() async {
        await _noteRepo.delete(noteId).getOrThrow();
        if (folderId != null) {
          await _folderRepo.decrementNoteCount(folderId).getOrThrow();
        }
        return Nothing.instance;
      });
}

class RefreshNotesWithFolderUpdateUseCase {
  final NoteRepository _noteRepo;

  RefreshNotesWithFolderUpdateUseCase(this._noteRepo);

  /// Refreshes notes and updates folder counts.
  AsyncResultDart<Nothing, AppError> call() => runCatchingAsync(() async {
    await _noteRepo.refresh().getOrThrow();
    return Nothing.instance;
  });
}
