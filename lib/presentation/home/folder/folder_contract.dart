import 'package:flutter/material.dart';

import '../../../domain/models/folder.dart';

/// UI model for your list/grid/etc.
class FolderUiItem {
  final String id;
  final String name;
  final int noteCount;
  final FolderType type;

  FolderUiItem({
    required this.id,
    required this.name,
    required this.noteCount,
    required this.type,
  });
}

extension FolderTypeColor on FolderType {
  /// The chip background color for each folder type
  Color get chipColor {
    switch (this) {
      case FolderType.work:
        return Colors.blue.shade100;
      case FolderType.personal:
        return Colors.green.shade100;
      case FolderType.study:
        return Colors.purple.shade100;
      case FolderType.ideas:
        return Colors.orange.shade100;
      case FolderType.other:
        return Colors.grey.shade100;
      case FolderType.all:
        return Colors.white; // Default for "All" folder
    }
  }

  /// (Optional) A contrasting text/icon color
  Color get foregroundColor {
    switch (this) {
      case FolderType.work:
        return Colors.blue.shade400;
      case FolderType.personal:
        return Colors.green.shade400;
      case FolderType.study:
        return Colors.purple.shade400;
      case FolderType.ideas:
        return Colors.orange.shade400;
      case FolderType.other:
        return Colors.grey.shade400;
      case FolderType.all:
        return Colors.purple.shade400; // Default for "All" folder
    }
  }
}

extension FolderTypeIcon on FolderType {
  IconData get icon {
    switch (this) {
      case FolderType.work:
        return Icons.work_outline;
      case FolderType.personal:
        return Icons.person_outline;
      case FolderType.study:
        return Icons.menu_book_outlined;
      case FolderType.ideas:
        return Icons.lightbulb_outline;
      case FolderType.other:
        return Icons.folder_open_outlined;
      case FolderType.all:
        return Icons.all_inclusive_outlined;
    }
  }
}

extension FolderUiMapper on Folder {
  FolderUiItem toUiItem() {
    return FolderUiItem(id: id, name: name, noteCount: totalNotes, type: type);
  }
}
