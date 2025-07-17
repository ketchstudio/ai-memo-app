import 'package:ana_flutter/presentation/home/folder/folder_card.dart';
import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:flutter/material.dart';

class FolderListView extends StatelessWidget {
  final List<FolderUiItem> folders;
  final Function(String) onFolderSelected;

  const FolderListView({
    super.key,
    required this.folders,
    required this.onFolderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: folders
            .map(
              (folder) => FolderCard(
                folder: folder,
                onFolderSelected: onFolderSelected,
              ),
            )
            .toList(),
      ),
    );
  }
}
