// create_text_note_state.dart
import 'package:ana_flutter/domain/models/note.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

enum CreateFileNoteStatus { initial, submitting, success, failure }

class CreateFileNoteState extends Equatable {
  final String title;
  final String path;
  final String description;
  final String folderId;
  final int fileSize;
  final FolderType folderType;
  final NoteType noteType;
  final CreateFileNoteStatus status;
  final String? errorMessage;

  const CreateFileNoteState({
    this.title = '',
    this.path = '',
    this.description = '',
    this.folderId = '',
    this.fileSize = 0,
    this.status = CreateFileNoteStatus.initial,
    this.errorMessage,
    this.folderType = FolderType.other,
    this.noteType = NoteType.unknown,
  });

  CreateFileNoteState copyWith({
    String? title,
    String? path,
    String? description,
    String? folderId,
    CreateFileNoteStatus? status,
    String? errorMessage,
    FolderType? folderType,
    NoteType? noteType,
  }) {
    return CreateFileNoteState(
      title: title ?? this.title,
      path: path ?? this.path,
      description: description ?? this.description,
      folderId: folderId ?? this.folderId,
      status: status ?? this.status,
      folderType: folderType ?? this.folderType,
      noteType: noteType ?? this.noteType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    title,
    path,
    description,
    folderId,
    status,
    errorMessage,
  ];
}
