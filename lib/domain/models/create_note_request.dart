import 'package:ana_flutter/domain/models/folder.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:equatable/equatable.dart';

class CreateNoteRequest extends Equatable {
  final String title;
  final String content;
  final String? folderId;
  final FolderType folderType;
  final String? url;
  final NoteType type;
  final String? fileRemotePath;

  const CreateNoteRequest({
    required this.title,
    required this.content,
    required this.folderId,
    required this.folderType,
    required this.type,
    this.url,
    this.fileRemotePath,
  });

  /// Serialize to JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'folder_type': folderType.index,
      'type': type.index,
      if (url != null) 'youtube_url': url,
      if (fileRemotePath != null) 'file_remote_path': fileRemotePath,
      if (folderId != null) 'folder_id': folderId,
    };
  }

  @override
  List<Object?> get props => [title, content, folderId, folderType, type];
}
