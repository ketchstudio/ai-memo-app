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

Color getFolderColor(int index) {
  // Example: assign color based on name hash or folder id
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
    Colors.indigo,
    Colors.brown,
    Colors.amber,
    Colors.lime,
    Colors.deepOrange,
  ];
  return colors[index % colors.length];
}

// noteCount can be passed in or default to 0
extension FolderUiMapper on Folder {
  FolderUiItem toUiItem(int index) {
    return FolderUiItem(
      id: id,
      name: name,
      icon: getFolderIcon(this),
      noteCount: totalNotes,
      color: getFolderColor(index),
    );
  }
}
