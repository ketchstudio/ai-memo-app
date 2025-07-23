import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/widget/inverse_text_button.dart';
import '../../theme/app_border_radius.dart';
import '../../theme/app_text_styles.dart';
import 'note_card.dart';

class NotesList extends StatelessWidget {
  final List<NoteUiItem> notes;
  final Function(String, String) onDelete;

  const NotesList({super.key, required this.notes, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: notes
          .map((note) => note)
          .map(
            (ui) => NoteCard(
              item: ui,
              onDelete: () async {
                final confirmed = await _showConfirmDeleteNoteDialog(
                  context: context,
                  noteTitle: ui.title,
                );
                if (confirmed == true) {
                  onDelete(ui.id, ui.folderId);
                }
              },
            ),
          )
          .toList(),
    );
  }
}

Future<bool?> _showConfirmDeleteNoteDialog({
  required BuildContext context,
  required String noteTitle,
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
        'Are you sure you want to permanently delete\n“$noteTitle”?',
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
