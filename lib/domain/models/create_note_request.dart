import 'package:equatable/equatable.dart';

class CreateNoteRequest extends Equatable {
  final String title;
  final String content;
  final String folderId;

  const CreateNoteRequest({
    required this.title,
    required this.content,
    required this.folderId,
  });

  /// Deserialize from JSON map
  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) {
    return CreateNoteRequest(
      title: json['title'] as String,
      content: json['content'] as String,
      folderId: json['folder_id'] as String,
    );
  }

  /// Serialize to JSON map
  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content, 'folder_id': folderId};
  }

  @override
  List<Object?> get props => [title, content, folderId];
}
