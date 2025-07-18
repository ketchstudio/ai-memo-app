import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FolderSelector extends StatelessWidget {
  final List<FolderUiItem> folders;
  final int selectedIndex;
  final ValueChanged<String> onSelected;

  const FolderSelector({
    required this.folders,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: folders.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(folders[index].id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: folders[index].type.chipColor.withValues(
                  alpha: isSelected ? 1 : 0.5,
                ),
                borderRadius: BorderRadius.circular(32),
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
                        color: isSelected
                            ? Colors.white
                            : folders[index].type.foregroundColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        folders[index].name,
                        style: AppTextStyles.bodySmall(context)
                            .withFontWeight(FontWeight.bold)
                            .copyWith(
                              color: isSelected ? Colors.white : Colors.black87,
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
