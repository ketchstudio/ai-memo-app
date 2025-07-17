import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/presentation/widget/rounded_icon_button.dart';
import '../app/bloc/folder/folder_bloc.dart';
import '../app/bloc/folder/folder_event.dart';
import '../app/bloc/folder/folder_state.dart';

class FolderManagementScreen extends StatelessWidget {
  const FolderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Folders'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
            child: RoundedIconButton(
              onPressed: () {},
              icon: Icons.add,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FolderBloc, FolderState>(
        builder: (context, state) {
          return Expanded(
            child: Stack(
              children: [
                if (state is FolderLoading)
                  const Center(child: CircularProgressIndicator()),
                if (state is FolderLoadSuccess && state.folders.isEmpty)
                  const Center(child: Text('No folders available')),
                if (state is FolderLoadSuccess && state.folders.isNotEmpty)
                  ListView.builder(
                    itemCount: state.folders.length,
                    itemBuilder: (context, index) {
                      final folder = state.folders[index];
                      return _FolderCard(
                        folder: folder,
                        onEdit: () {},
                        onDelete: () {
                          // Handle delete action
                          context.read<FolderBloc>().add(
                            DeleteFolder(folder.id),
                          );
                        },
                      );
                    },
                  ),
                if (state is FolderFailure)
                  Center(child: Text('Error: ${state.message}')),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FolderCard extends StatelessWidget {
  final FolderUiItem folder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FolderCard({
    super.key,
    required this.folder,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: folder.color.withValues(alpha: 0.01),
        border: Border.all(
          color: folder.color.withValues(alpha: 0.1),
          width: 1,
        ),
        borderRadius: AppBorderRadius.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // folder icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: folder.color.withValues(alpha: 0.1),
                borderRadius: AppBorderRadius.button,
              ),
              child: Icon(folder.icon, size: 24, color: folder.color),
            ),
            const SizedBox(width: 12),
            // title & count
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  folder.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${folder.noteCount} notes',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            // edit button
            // optional delete button
            RoundedIconButton(
              size: 24,
              onPressed: onEdit,
              icon: Icons.edit,
              color: Colors.grey,
            ),

            const SizedBox(width: 8),

            RoundedIconButton(
              size: 24,
              onPressed: onDelete,
              icon: Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
