// create_text_note_state.dart
import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

enum CreateYoutubeNoteStatus { initial, submitting, success, failure }

class CreateYoutubeNoteState extends Equatable {
  final String title;
  final String url;
  final String description;
  final String folderId;
  final FolderType folderType;
  final CreateYoutubeNoteStatus status;
  final String? errorMessage;

  const CreateYoutubeNoteState({
    this.title = '',
    this.url = '',
    this.description = '',
    this.folderId = '',
    this.status = CreateYoutubeNoteStatus.initial,
    this.errorMessage,
    this.folderType = FolderType.other,
  });

  CreateYoutubeNoteState copyWith({
    String? title,
    String? url,
    String? description,
    String? folderId,
    CreateYoutubeNoteStatus? status,
    String? errorMessage,
    FolderType? folderType,
  }) {
    return CreateYoutubeNoteState(
      title: title ?? this.title,
      url: url ?? this.url,
      description: description ?? this.description,
      folderId: folderId ?? this.folderId,
      status: status ?? this.status,
      folderType: folderType ?? this.folderType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    title,
    url,
    description,
    folderId,
    status,
    errorMessage,
  ];
}
