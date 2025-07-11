import 'package:flutter/material.dart';

import '../../core/presentation/widget/gradient_icon_button.dart';

class HomeMainAction extends StatelessWidget {
  final VoidCallback onAddTap;
  final VoidCallback onMindMapTap;
  final VoidCallback onExploreTap;

  const HomeMainAction({
    super.key,
    required this.onAddTap,
    required this.onMindMapTap,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientIconButton(
          size: 56,
          icon: Icons.add,
          gradientColors: [Color(0xFF9B5FFF), Color(0xFF7D6AFF)],
          onTap: onAddTap,
        ),
        SizedBox(width: 12),
        GradientIconButton(
          size: 56,
          icon: Icons.account_tree_outlined,
          gradientColors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
          onTap: onMindMapTap,
        ),
        SizedBox(width: 12),
        GradientIconButton(
          size: 56,
          icon: Icons.auto_fix_high,
          gradientColors: [Color(0xFFFF5722), Color(0xFFE64A19)],
          onTap: onExploreTap,
        ),
      ],
    );
  }
}
