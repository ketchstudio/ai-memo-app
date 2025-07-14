import 'package:flutter/material.dart';

import '../../../domain/models/folder.dart';

class FolderUiItem {
  final String id;
  final String name;
  final IconData icon;
  final int noteCount;
  final Color color;

  FolderUiItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.noteCount,
    required this.color,
  });
}

// You may want a custom mapping for icons and colors:
IconData getFolderIcon(Folder folder) {
  // Example: assign based on name, id, or metadata
  return Icons.folder;
}

Color getFolderColor(Folder folder) {
  // Example: assign color based on name hash or folder id
  final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];
  final hash = folder.id.hashCode.abs();
  return colors[hash % colors.length];
}

// noteCount can be passed in or default to 0
extension FolderUiMapper on Folder {
  FolderUiItem toUiItem() {
    return FolderUiItem(
      id: id,
      name: name,
      icon: getFolderIcon(this),
      noteCount: totalNotes,
      color: getFolderColor(this),
    );
  }
}
