import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_border.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FolderCard extends StatelessWidget {
  final FolderUiItem folder;
  final Function(String) onFolderSelected;

  const FolderCard({
    super.key,
    required this.folder,
    required this.onFolderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => onFolderSelected(folder.id),
        borderRadius: AppBorderRadius.card,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: folder.color.withValues(alpha: 0.1),
            borderRadius: AppBorderRadius.card,
            border: AppBorder.card(folder.color.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Row(
                  children: [
                    Icon(folder.icon, size: 24, color: folder.color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        folder.name,
                        style: AppTextStyles.bodyMedium(
                          context,
                        ).withFontWeight(FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${folder.noteCount} notes',
                style: AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
