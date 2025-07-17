import 'package:flutter/material.dart';

import '../../../presentation/theme/app_border_radius.dart';

class RoundedIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double size;

  const RoundedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: AppBorderRadius.button,
      child: Container(
        padding: const EdgeInsets.all(8.0), // padding around the icon
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), // background color
          shape: BoxShape.rectangle, // circular shape
          borderRadius: AppBorderRadius.button, // rounded corners
        ),
        // Center the IconButton inside the container
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
