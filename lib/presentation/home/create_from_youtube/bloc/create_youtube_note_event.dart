// create_text_note_event.dart
import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

abstract class CreateYoutubeNoteEvent extends Equatable {
  const CreateYoutubeNoteEvent();

  @override
  List<Object?> get props => [];
}

/// User edited the title field
class TitleChanged extends CreateYoutubeNoteEvent {
  final String title;

  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class DescriptionChanged extends CreateYoutubeNoteEvent {
  final String description;

  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class UrlChanged extends CreateYoutubeNoteEvent {
  final String url;

  const UrlChanged(this.url);

  @override
  List<Object?> get props => [url];
}

/// User picked a folder
class FolderSelected extends CreateYoutubeNoteEvent {
  final String folderId;
  final FolderType folderType;

  const FolderSelected(this.folderId, this.folderType);

  @override
  List<Object?> get props => [folderId];
}

/// User tapped “Create”
class SubmitNote extends CreateYoutubeNoteEvent {
  const SubmitNote();
}
