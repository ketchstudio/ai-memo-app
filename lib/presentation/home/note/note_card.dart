import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_border.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'note_menu.dart';
import 'note_ui_item.dart';

class NoteCard extends StatelessWidget {
  final NoteUiItem item;
  final VoidCallback onDelete;

  const NoteCard({super.key, required this.item, required this.onDelete});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.only(
        top: 4,
        left: 16,
        right: 0,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: AppBorder.outline(
          theme.colorScheme.onSurface.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).withFontWeight(FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              NoteMenu(onDelete: onDelete),
            ],
          ),

          const SizedBox(height: 8),
          // ── Snippet
          Text(
            item.snippet,
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),
          // ── Bottom row: NoteType chip, FolderType chip, timestamp, brain-icon
          Row(
            children: [
              // NoteType chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: item.type.chipColor.withValues(alpha: 0.8),
                  borderRadius: AppBorderRadius.circle(),
                ),
                child: Row(
                  children: [
                    Icon(item.type.icon, size: 16, color: item.type.textColor),
                    const SizedBox(width: 4),
                    Text(
                      item.type.name,
                      style: AppTextStyles.bodySmall(context)
                          .copyWith(color: item.type.textColor)
                          .withFontWeight(FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: item.folderType.chipColor.withValues(alpha: 0.8),
                  borderRadius: AppBorderRadius.circle(),
                ),
                child: Row(
                  children: [
                    Icon(
                      item.folderType.icon,
                      size: 16,
                      color: item.folderType.foregroundColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.folderType.name,
                      style: AppTextStyles.bodySmall(context)
                          .copyWith(color: item.folderType.foregroundColor)
                          .withFontWeight(FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              // timestamp
              Text(_timeAgo(item.createdAt), style: theme.textTheme.bodySmall),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
