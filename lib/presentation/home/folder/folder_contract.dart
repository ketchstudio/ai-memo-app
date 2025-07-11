import 'package:flutter/material.dart';

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

final List<FolderUiItem> folders = [
  FolderUiItem(
    id: '1',
    name: 'All Notes',
    icon: Icons.folder,
    noteCount: 42,
    color: const Color(0xFF36394C),
    // dark gray
  ),
  FolderUiItem(
    id: "2",
    name: 'Work',
    icon: Icons.work,
    noteCount: 12,
    color: const Color(0xFF2563EB),
  ),
  FolderUiItem(
    id: "3",
    name: 'Study',
    icon: Icons.school,
    noteCount: 8,
    color: const Color(0xFF22C55E),
  ),
  FolderUiItem(
    id: "4",
    name: 'Personal',
    icon: Icons.person,
    noteCount: 5,
    color: const Color(0xFFEC4899),
  ),
  FolderUiItem(
    id: "5",
    name: 'Ideas',
    icon: Icons.lightbulb,
    noteCount: 3,
    color: const Color(0xFF8B5CF6),
  ),
  FolderUiItem(
    id: "6",
    name: 'Travel',
    icon: Icons.airplanemode_active,
    noteCount: 7,
    color: const Color(0xFF10B981),
  ),
];
