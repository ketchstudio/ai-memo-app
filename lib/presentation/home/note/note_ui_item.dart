import 'package:flutter/material.dart';

import '../../../domain/models/folder.dart'; // for FolderType
import '../../../domain/models/note.dart';

/// 1) A little UI‐only model
class NoteUiItem {
  final String id;
  final String title;
  final String snippet;
  final DateTime createdAt;
  final NoteType type;
  final FolderType folderType;
  final Color statusDotColor;

  NoteUiItem({
    required this.id,
    required this.title,
    required this.snippet,
    required this.createdAt,
    required this.type,
    required this.folderType,
    this.statusDotColor = Colors.green,
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
  NoteUiItem toUiItem({Color statusDotColor = Colors.green}) {
    return NoteUiItem(
      id: id,
      title: title,
      snippet: _makeSnippet(content),
      createdAt: createdAt,
      type: type,
      folderType: folderType,
      statusDotColor: statusDotColor,
    );
  }
}

extension NoteTypeIcon on NoteType {
  /// Returns the appropriate icon for each note type
  IconData get icon {
    switch (this) {
      case NoteType.audio:
        return Icons.mic;
      case NoteType.text:
        return Icons.text_snippet;
      case NoteType.document:
        return Icons.picture_as_pdf;
      case NoteType.video:
        return Icons.videocam;
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
    }
  }
}

final List<Note> dummyNotes = [
  Note(
    id: '1',
    title: 'AI Strategy Meeting',
    content:
        'Discussed implementation of AI agents for customer support, including fallback flows and monitoring dashboards.',
    folderId: 'work',
    createdAt: DateTime.now().subtract(Duration(hours: 2)),
    type: NoteType.text,
    // Assuming this is a text note
    folderType: FolderType.work, // Assuming this note belongs to a work folder
  ),
  Note(
    id: '2',
    title: 'Learning Mindmap',
    content:
        'Machine learning concepts and neural networks overview: perceptrons, backpropagation, CNNs, RNNs, and transformers.',
    folderId: 'study',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    type: NoteType.audio,
    // Assuming this is a text note
    folderType:
        FolderType.study, // Assuming this note belongs to a study folder
  ),
  Note(
    id: '3',
    title: 'App Ideas',
    content:
        'Brainstorming session for new mobile app features, including offline mode, dark theme, chat integration, and AR previews.',
    folderId: 'ideas',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    type: NoteType.document,
    // Assuming this is a text note
    folderType:
        FolderType.ideas, // Assuming this note belongs to an ideas folder
  ),
  Note(
    id: '4',
    title: 'Python Tutorial',
    content:
        'Complete guide to Python programming fundamentals: variables, data types, control flow, functions, OOP, and modules.',
    folderId: 'study',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    type: NoteType.video,
    // Assuming this is a text note
    folderType:
        FolderType.study, // Assuming this note belongs to a study folder
  ),
];
