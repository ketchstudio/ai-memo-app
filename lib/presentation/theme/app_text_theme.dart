import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextThemes {
  AppTextThemes._(); // Prevent instantiation

  /// Light theme text styles (based on Material 3)
  static final TextTheme light = GoogleFonts.interTextTheme(
    _baseLightTextTheme,
  );

  /// Dark theme text styles (based on Material 3)
  static final TextTheme dark = GoogleFonts.interTextTheme(_baseDarkTextTheme);

  /// Material 3 base with AppColors (light)
  static const TextTheme _baseLightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),

    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),

    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.dark,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFF6B7280),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0xFF9CA3AF),
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
  );

  /// Material 3 base with AppColors (dark)
  static const TextTheme _baseDarkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),

    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),

    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.light,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.light,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.light,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.light,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFFCBD5E1),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0xFF94A3B8),
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.light,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.light,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.light,
    ),
  );
}
