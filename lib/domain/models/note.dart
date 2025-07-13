import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String folderId;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.folderId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, content, folderId, createdAt];
}
