// create_text_note_state.dart
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

enum CreateTextNoteStatus { initial, submitting, success, failure }

class CreateTextNoteState extends Equatable {
  final String title;
  final String content;
  final String? folderId;
  final FolderType folderType;
  final CreateTextNoteStatus status;
  final AppError? error;

  const CreateTextNoteState({
    this.title = '',
    this.content = '',
    this.folderId,
    this.status = CreateTextNoteStatus.initial,
    this.folderType = FolderType.other,
    this.error,
  });

  CreateTextNoteState copyWith({
    String? title,
    String? content,
    String? folderId,
    CreateTextNoteStatus? status,
    AppError? error,
    FolderType? folderType,
  }) {
    return CreateTextNoteState(
      title: title ?? this.title,
      content: content ?? this.content,
      folderId: folderId ?? this.folderId,
      status: status ?? this.status,
      folderType: folderType ?? this.folderType,
      error: error,
    );
  }

  @override
  List<Object?> get props => [title, content, folderId, status, error];
}
