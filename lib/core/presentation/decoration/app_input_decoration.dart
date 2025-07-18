import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

InputDecoration appInputDecoration({
  required BuildContext context,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool filled = false,
  double borderRadius = 16,
  EdgeInsets contentPadding = const EdgeInsets.all(16),
}) {
  final theme = Theme.of(context);

  // Dynamically scale font based on system text scale or screen size
  return InputDecoration(
    hintText: hintText,
    hintStyle: AppTextStyles.bodyMedium(
      context,
    ).withFontWeight(FontWeight.bold),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: contentPadding,
    filled: filled,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 1),
    ),
  );
}
