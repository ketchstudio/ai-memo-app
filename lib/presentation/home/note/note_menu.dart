import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:flutter/material.dart';

/// A tiny three‑dot menu with a single “Delete” entry.
class NoteMenu extends StatelessWidget {
  /// Called when the user taps “Delete”
  final VoidCallback onDelete;

  /// Optional: you can pass other menu entries later
  const NoteMenu({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuAction>(
      menuPadding: EdgeInsets.zero,
      borderRadius: AppBorderRadius.card,
      padding: EdgeInsets.zero,
      offset: const Offset(-8, 8), // Position the menu below the button
      // Icon for the button; swap out for whatever you like
      icon: Icon(
        size: 20,
        Icons.more_vert,
        color: Theme.of(context).iconTheme.color,
      ),
      onSelected: (action) {
        switch (action) {
          case _MenuAction.delete:
            // confirm? or go straight to delete
            onDelete();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuAction>(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          value: _MenuAction.delete,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

enum _MenuAction { delete }
