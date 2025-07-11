import 'package:flutter/material.dart';

enum NoteOption {
  text(
    icon: Icons.edit,
    iconColor: Colors.blueAccent,
    title: 'Text',
    subtitle: 'Create a text note',
  ),
  recordAudio(
    icon: Icons.mic,
    iconColor: Colors.redAccent,
    title: 'Record Audio',
    subtitle: 'Record voice note',
  ),
  uploadImage(
    icon: Icons.image,
    iconColor: Colors.green,
    title: 'Upload Image',
    subtitle: 'Add image to note',
  ),
  youtube(
    icon: Icons.video_library,
    iconColor: Colors.red,
    title: 'YouTube',
    subtitle: 'Import from YouTube',
  ),
  documentFile(
    icon: Icons.insert_drive_file,
    iconColor: Colors.purple,
    title: 'Document File',
    subtitle: 'PDF, DOCX, and more',
  );

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const NoteOption({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
