import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> folders;
  final String selectedFolder;
  final Function(String) onFolderSelected;
  final VoidCallback onNavigateToSettings;

  const HomeAppBar({
    super.key,
    required this.folders,
    required this.selectedFolder,
    required this.onFolderSelected,
    required this.onNavigateToSettings,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: PopupMenuButton<String>(
        borderRadius: BorderRadius.circular(8),
        onSelected: onFolderSelected,
        itemBuilder: (context) => folders
            .map((folder) => PopupMenuItem(value: folder, child: Text(folder)))
            .toList(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.folder),
              const SizedBox(width: 8),
              Text(selectedFolder),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onNavigateToSettings,
        ),
      ],
    );
  }
}
