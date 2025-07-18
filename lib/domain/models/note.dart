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
  text("Text"),
  audio("Audio"),
  document("Document"),
  video("Video");

  final String name;

  const NoteType(this.name);
}
