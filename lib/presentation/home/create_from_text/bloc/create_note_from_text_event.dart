// create_text_note_event.dart
import 'package:equatable/equatable.dart';

abstract class CreateTextNoteEvent extends Equatable {
  const CreateTextNoteEvent();

  @override
  List<Object?> get props => [];
}

/// User edited the title field
class TitleChanged extends CreateTextNoteEvent {
  final String title;

  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

/// User edited the content field
class ContentChanged extends CreateTextNoteEvent {
  final String content;

  const ContentChanged(this.content);

  @override
  List<Object?> get props => [content];
}

/// User picked a folder
class FolderSelected extends CreateTextNoteEvent {
  final String folderId;

  const FolderSelected(this.folderId);

  @override
  List<Object?> get props => [folderId];
}

/// User tapped “Create”
class SubmitNote extends CreateTextNoteEvent {
  const SubmitNote();
}
