import 'package:flutter/material.dart';

import '../../../domain/models/folder.dart'; // for FolderType
import '../../../domain/models/note.dart';

/// 1) A little UI‐only model
class NoteUiItem {
  final String id;
  final String folderId;
  final String title;
  final String snippet;
  final DateTime createdAt;
  final NoteType type;
  final FolderType folderType;
  final String folderName;

  NoteUiItem({
    required this.id,
    required this.folderId,
    required this.title,
    required this.snippet,
    required this.createdAt,
    required this.type,
    required this.folderType,
    required this.folderName,
  });
}

/// 2) A helper to turn long content into a 2-line snippet
String _makeSnippet(String content, {int wordLimit = 12}) {
  final words = content.split(RegExp(r'\s+'));
  if (words.length <= wordLimit) return content;
  return '${words.take(wordLimit).join(' ')}…';
}

/// 3) Extension on your domain Note
extension NoteUiMapper on Note {
  /// You must supply the NoteType (audio, text, doc, video…)
  /// and the FolderType (work, personal, study, ideas, other).
  NoteUiItem toUiItem() {
    return NoteUiItem(
      id: id,
      folderId: folderId,
      title: title,
      snippet: _makeSnippet(url ?? content, wordLimit: 12),
      createdAt: createdAt,
      type: type,
      folderType: folderType,
      folderName: folderName,
    );
  }
}

extension NoteTypeIcon on NoteType {
  /// Returns the appropriate icon for each note type
  IconData? get icon {
    switch (this) {
      case NoteType.audio:
        return Icons.mic;
      case NoteType.text:
        return Icons.text_snippet;
      case NoteType.document:
        return Icons.picture_as_pdf;
      case NoteType.video:
        return Icons.videocam;
      case NoteType.image:
        return Icons.image;
      case NoteType.unknown:
        return null; // No icon for unknown type
    }
  }
}

extension NoteTypeColor on NoteType {
  /// Background color for the type‐chip
  Color get chipColor {
    switch (this) {
      case NoteType.audio:
        return Colors.red.shade100;
      case NoteType.text:
        return Colors.grey.shade200;
      case NoteType.document:
        return Colors.blue.shade100;
      case NoteType.video:
        return Colors.red.shade100;
      case NoteType.image:
        return Colors.green.shade100; // Assuming image type has a color
      case NoteType.unknown:
        return Colors.transparent; // No color for unknown type
    }
  }

  /// Text/Icon color for the type‐chip
  Color get textColor {
    switch (this) {
      case NoteType.audio:
      case NoteType.video:
        return Colors.red.shade800;
      case NoteType.text:
        return Colors.grey.shade800;
      case NoteType.document:
        return Colors.blue.shade800;
      case NoteType.unknown:
        return Colors.transparent; // Default text color for unknown type
      case NoteType.image:
        return Colors.green.shade800; // Assuming image type has a color
    }
  }
}
