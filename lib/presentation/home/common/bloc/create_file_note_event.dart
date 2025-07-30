// create_text_note_event.dart
import 'package:equatable/equatable.dart';

import '../../../../domain/models/app_file.dart';
import '../../../../domain/models/folder.dart';
import '../file_picker_with_preview.dart';

abstract class CreateFileNoteEvent extends Equatable {
  const CreateFileNoteEvent();

  @override
  List<Object?> get props => [];
}

class CreateFileNoteInitial extends CreateFileNoteEvent {
  final String fileName;
  final AppFileType fileType;
  final String fileSize;
  final String fileExtension;
  final String path;

  const CreateFileNoteInitial({
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.fileExtension,
    required this.path,
  });
}

/// User picked a folder
class FolderSelected extends CreateFileNoteEvent {
  final String folderId;
  final FolderType folderType;

  const FolderSelected(this.folderId, this.folderType);

  @override
  List<Object?> get props => [folderId, folderType];
}

class FileSelected extends CreateFileNoteEvent {
  final AppFile file;

  const FileSelected(this.file);

  @override
  List<Object?> get props => [file];
}

/// User tapped “Create”
class SubmitNote extends CreateFileNoteEvent {
  const SubmitNote();
}
