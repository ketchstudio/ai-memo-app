import 'package:ana_flutter/domain/models/folder.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String folderId;
  final NoteType type;
  final FolderType folderType;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.folderId,
    required this.type,
    required this.folderType,
    required this.createdAt,
  });

  /// Deserialize from JSON map
  /// This is typically used when fetching from a remote source
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      folderId: json['folder_id'] as String,
      type: NoteType.values.firstWhere(
        (e) => e.index == json['type'],
        orElse: () => NoteType.unknown, // Default to text if not found
      ),
      folderType: FolderType.values.firstWhere(
        (e) => e.index == json['folder_type'],
        orElse: () => FolderType.other, // Default to other if not found
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    folderId,
    createdAt,
    type,
    folderType,
  ];
}

enum NoteType {
  unknown("None"),
  text("Text"),
  audio("Audio"),
  document("Document"),
  video("Video");

  final String name;

  const NoteType(this.name);
}
