import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/core/presentation/widget/inverse_text_button.dart';
import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_border.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
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
              onPressed: () {
                showFolderNameDialog(
                  context: context,
                  initialName: '',
                  title: 'Create New Folder',
                  confirmLabel: 'Create',
                ).then((newName) {
                  if (newName != null && newName.isNotEmpty) {
                    if (!context.mounted) return;
                    context.read<FolderBloc>().add(CreateFolder(newName));
                  }
                });
              },
              icon: Icons.add,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ],
      ),
      body: BlocConsumer<FolderBloc, FolderState>(
        listener: (context, state) {
          if (state is EditFolderLoadSuccess) {
            SnackbarManager.show(
              message: 'Folder renamed successfully!',
              type: SnackbarType.success,
            );
          }

          if (state is DeleteFolderLoadSuccess) {
            SnackbarManager.show(
              message: 'Folder deleted successfully!',
              type: SnackbarType.success,
            );
          }

          if (state is CreateFolderLoadSuccess) {
            SnackbarManager.show(
              message: 'Folder created successfully!',
              type: SnackbarType.success,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is FolderLoading)
                const Center(child: CircularProgressIndicator()),

              if (state is FolderLoadSuccess && state.folders.isEmpty)
                const Center(child: Text('No folders available')),

              ListView.builder(
                itemCount: state.folders.length,
                itemBuilder: (context, index) {
                  final folder = state.folders[index];
                  return _FolderCard(
                    folder: folder,
                    onEdit: () async {
                      final newName = await showFolderNameDialog(
                        context: context,
                        initialName: folder.name,
                        title: 'Edit Folder Name',
                        confirmLabel: 'Save',
                      );
                      if (newName != null && newName != folder.name) {
                        if (!context.mounted) return;
                        context.read<FolderBloc>().add(
                          EditFolder(folder.id, newName),
                        );
                      }
                    },
                    onDelete: () {
                      _showConfirmDeleteFolderDialog(
                        context: context,
                        folderName: folder.name,
                      ).then((confirmed) {
                        if (confirmed == true) {
                          context.read<FolderBloc>().add(
                            DeleteFolder(folder.id),
                          );
                        }
                      });
                    },
                  );
                },
              ),
              if (state is FolderFailure)
                Center(child: Text('Error: ${state.message}')),
            ],
          );
        },
      ),
    );
  }
}

Future<String?> showFolderNameDialog({
  required BuildContext context,
  required String initialName,
  required String title,
  required String confirmLabel,
}) {
  final controller = TextEditingController(text: initialName);
  final formKey = GlobalKey<FormState>();

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      const horizontalInset = 16.0;
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalInset),
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
        title: Text(title, style: AppTextStyles.titleMedium(context)),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              style: AppTextStyles.bodyMedium(context),
              decoration: appInputDecoration(
                context: context,
                hintText: 'Folder name',
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Name can\'t be empty' : null,
            ),
          ),
        ),

        actions: [
          InverseTextButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(ctx).pop(null),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.onSurface.withOpacity(0.1),
            textStyle: AppTextStyles.bodyMedium(
              context,
            ).withFontWeight(FontWeight.bold),
            textColor: Theme.of(context).colorScheme.onSurface,
          ),
          InverseTextButton(
            text: confirmLabel,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(ctx).pop(controller.text.trim());
              }
            },
          ),
        ],
      );
    },
  );
}

Future<bool?> _showConfirmDeleteFolderDialog({
  required BuildContext context,
  required String folderName,
}) {
  final theme = Theme.of(context);
  const horizontalInset = 16.0;
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: horizontalInset),
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
      title: Text(
        'Delete Folder?',
        style: theme.textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Are you sure you want to permanently delete\n“$folderName”?',
        style: theme.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        InverseTextButton(
          text: 'Cancel',
          onPressed: () => Navigator.of(context).pop(null),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.onSurface.withOpacity(0.1),
          textStyle: AppTextStyles.bodyMedium(
            context,
          ).withFontWeight(FontWeight.bold),
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        InverseTextButton(
          text: 'Delete',
          backgroundColor: Theme.of(context).colorScheme.error,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

class _FolderCard extends StatelessWidget {
  final FolderUiItem folder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FolderCard({
    required this.folder,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: folder.type.chipColor.withValues(alpha: 0.1),
        border: AppBorder.outline(
          folder.type.foregroundColor.withValues(alpha: 0.5),
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
                color: folder.type.chipColor,
                borderRadius: AppBorderRadius.button,
              ),
              child: Icon(
                folder.type.icon,
                size: 24,
                color: folder.type.foregroundColor,
              ),
            ),
            const SizedBox(width: 12),
            // title & count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    folder.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${folder.noteCount} notes',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
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
