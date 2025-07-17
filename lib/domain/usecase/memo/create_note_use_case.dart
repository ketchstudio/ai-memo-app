// lib/datasource/usecases/note_folder_usecases.dart

import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/repositories/folder_repository.dart';
import 'package:ana_flutter/domain/repositories/memo_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/result/result_ext.dart';

class CreateNoteWithFolderUpdateUseCase {
  final NoteRepository _noteRepo;
  final FolderRepository _folderRepo;

  CreateNoteWithFolderUpdateUseCase(this._noteRepo, this._folderRepo);

  /// Creates the note, then bumps the folder's totalNotes count.
  AsyncResultDart<Nothing, AppError> call(CreateNoteRequest params) =>
      runCatchingAsync(() async {
        await _noteRepo.createNote(body: params).getOrThrow();
        await _folderRepo.incrementNoteCount(params.folderId);
        return Nothing.instance;
      });
}
