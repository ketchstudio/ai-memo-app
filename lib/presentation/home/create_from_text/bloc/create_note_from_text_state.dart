// create_text_note_state.dart
import 'package:equatable/equatable.dart';

enum CreateTextNoteStatus { initial, submitting, success, failure }

class CreateTextNoteState extends Equatable {
  final String title;
  final String content;
  final String folderId;
  final CreateTextNoteStatus status;
  final String? errorMessage;

  const CreateTextNoteState({
    this.title = '',
    this.content = '',
    this.folderId = '',
    this.status = CreateTextNoteStatus.initial,
    this.errorMessage,
  });

  CreateTextNoteState copyWith({
    String? title,
    String? content,
    String? folderId,
    CreateTextNoteStatus? status,
    String? errorMessage,
  }) {
    return CreateTextNoteState(
      title: title ?? this.title,
      content: content ?? this.content,
      folderId: folderId ?? this.folderId,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [title, content, folderId, status, errorMessage];
}
