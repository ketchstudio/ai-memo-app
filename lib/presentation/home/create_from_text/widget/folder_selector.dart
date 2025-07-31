import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FolderSelector extends StatelessWidget {
  final List<FolderUiItem> folders;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FolderSelector({
    required this.folders,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: folders.length,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: folders[index].type.chipColor.withValues(
                  alpha: isSelected ? 0.5 : 0.2,
                ),
                borderRadius: BorderRadius.circular(32),
                border: isSelected
                    ? Border.all(
                        color: folders[index].type.foregroundColor,
                        width: 0.5,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        size: 16,
                        folders[index].type.icon,
                        color: folders[index].type.foregroundColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        folders[index].name,
                        style: AppTextStyles.bodySmall(context)
                            .withFontWeight(FontWeight.bold)
                            .copyWith(
                              color: folders[index].type.foregroundColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
