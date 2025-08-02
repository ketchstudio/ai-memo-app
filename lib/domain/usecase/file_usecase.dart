import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/folder.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:ana_flutter/domain/repositories/auth_repository.dart';
import 'package:ana_flutter/domain/repositories/note_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../models/app_file.dart';
import '../models/create_note_request.dart';
import '../repositories/file_repository.dart';

class UploadFileUseCase {
  final FileRepository repository;
  final NoteRepository noteRepository;
  final AuthRepository authRepository;

  UploadFileUseCase(this.repository, this.noteRepository, this.authRepository);

  AsyncResultDart<Note, AppError> call({
    required String folderId,
    required AppFile file,
    required NoteType noteType,
    required FolderType folderType,
  }) async {
    final userId = authRepository.currentUserId().getOrThrow();
    final remotePath = await repository.uploadFile(file, userId).getOrThrow();
    return noteRepository.create(
      CreateNoteRequest(
        title: file.name,
        content: '',
        folderId: folderId,
        folderType: folderType,
        type: noteType,
        fileRemotePath: remotePath,
      ),
    );
  }
}
