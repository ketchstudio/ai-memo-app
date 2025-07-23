// create_text_note_state.dart
import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

enum CreateTextNoteStatus { initial, submitting, success, failure }

class CreateTextNoteState extends Equatable {
  final String title;
  final String content;
  final String folderId;
  final FolderType folderType;
  final CreateTextNoteStatus status;
  final String? errorMessage;

  const CreateTextNoteState({
    this.title = '',
    this.content = '',
    this.folderId = '',
    this.status = CreateTextNoteStatus.initial,
    this.errorMessage,
    this.folderType = FolderType.other,
  });

  CreateTextNoteState copyWith({
    String? title,
    String? content,
    String? folderId,
    CreateTextNoteStatus? status,
    String? errorMessage,
    FolderType? folderType,
  }) {
    return CreateTextNoteState(
      title: title ?? this.title,
      content: content ?? this.content,
      folderId: folderId ?? this.folderId,
      status: status ?? this.status,
      folderType: folderType ?? this.folderType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [title, content, folderId, status, errorMessage];
}
