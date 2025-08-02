import 'package:ana_flutter/domain/models/folder.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String? folderId;
  final NoteType type;
  final FolderType folderType;
  final DateTime createdAt;
  final String? url;
  final String? fileRemotePath; // Optional field for remote file path
  final String folderName;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.folderType,
    required this.createdAt,
    required this.folderName,
    this.folderId,
    this.url,
    this.fileRemotePath,
  });

  /// Deserialize from JSON map
  /// This is typically used when fetching from a remote source
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      folderId: json['folder_id'] as String?,
      type: NoteType.values.firstWhere(
        (e) => e.index == json['type'],
        orElse: () => NoteType.unknown, // Default to text if not found
      ),
      folderType: FolderType.values.firstWhere(
        (e) => e.index == json['folder_type'],
        orElse: () => FolderType.other, // Default to other if not found
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      url: json['youtube_url'] as String?,
      folderName: json['folder_name'] as String? ?? '',
      fileRemotePath: json['file_remote_path'] as String?,
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
    url,
    folderName,
  ];

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? folderId,
    NoteType? type,
    FolderType? folderType,
    DateTime? createdAt,
    String? url,
    String? folderName,
    String? fileRemotePath,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      folderId: folderId ?? this.folderId,
      type: type ?? this.type,
      folderType: folderType ?? this.folderType,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      folderName: folderName ?? this.folderName,
      fileRemotePath: fileRemotePath ?? this.fileRemotePath,
    );
  }
}

enum NoteType {
  unknown("None"),
  text("Text"),
  audio("Audio"),
  document("Document"),
  video("Video"),
  image("Image");

  final String name;

  const NoteType(this.name);
}
