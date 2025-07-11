import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'note_create_option.dart';

void showNoteCreateOptionBottomSheet(
  BuildContext context,
  Function(NoteOption option) onOptionSelected,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Create New Note',
            style: AppTextStyles.titleLarge(
              context,
            ).withFontWeight(FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...NoteOption.values.map(
            (option) => _buildOption(
              context: context,
              option: option,
              onTap: () {
                onOptionSelected(option);
              },
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyLarge(
                context,
              ).withFontWeight(FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOption({
  required BuildContext context,
  required NoteOption option,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(16),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: option.iconColor,
              child: Icon(option.icon, color: Colors.white),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).withFontWeight(FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(option.subtitle, style: AppTextStyles.bodyMedium(context)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
