import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSettingsPressed;

  const MainAppBar({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left Icon (App Logo)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: AppBorderRadius.field,
              ),
              child: Icon(
                size: 20,
                Icons.memory,
                color: Colors.white,
              ), // brain icon replacement
            ),

            SizedBox(width: 12),

            // Title
            Expanded(
              child: Text(
                'iMemo',
                style: AppTextStyles.headlineMedium(
                  context,
                ).withFontWeight(FontWeight.bold),
              ),
            ),

            // Settings Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onSettingsPressed,
                icon: Icon(Icons.settings, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
