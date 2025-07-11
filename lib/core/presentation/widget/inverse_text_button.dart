import 'package:flutter/material.dart';

Color getContrastingTextColor(Color backgroundColor) {
  return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

class InverseTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color? textColor;
  final EdgeInsets padding;

  const InverseTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final contrastColor = getContrastingTextColor(backgroundColor);
    final overrideTextColor = textColor ?? contrastColor;
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: contrastColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle?.copyWith(color: overrideTextColor)),
    );
  }
}
