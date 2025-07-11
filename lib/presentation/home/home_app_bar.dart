import 'package:ana_flutter/presentation/theme/app_colors.dart';
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
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(16),
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
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
