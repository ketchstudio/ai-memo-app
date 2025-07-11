import 'package:ana_flutter/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

/// A class to hold the custom color palette for the application.
/// This makes it easy to manage and reuse colors throughout the app.
class AppColors {
  // This class is not meant to be instantiated.
  // It's a container for static color constants.
  AppColors._();

  /// Primary color, used for main UI elements like app bars, buttons, etc.
  /// Hex: #6366f1
  static const Color primary = Color(0xFF6366F1);

  /// Secondary color, used for accents and secondary UI elements.
  /// Hex: #8b5cf6
  static const Color secondary = Color(0xFF8B5CF6);

  /// Accent color, used for highlighting or calling attention to specific elements.
  /// Hex: #06b6d4
  static const Color accent = Color(0xFF06B6D4);

  /// Dark color, typically used for text, icons, and dark theme backgrounds.
  /// Hex: #1f2937
  static const Color dark = Color(0xFF1F2937);

  /// Light color, often used for backgrounds in light mode or for text on dark backgrounds.
  /// Hex: #f8fafc
  static const Color light = Color(0xFFF8FAFC);
}

// --- Example Usage in a Flutter Theme ---

// You can integrate these colors directly into your app's ThemeData.
// This ensures a consistent look and feel across all widgets.

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    tertiary: AppColors.accent,
    surfaceContainerHighest: AppColors.dark,
    surface: Colors.white,
    onSurface: AppColors.dark,
    error: Colors.redAccent,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 1,
    iconTheme: IconThemeData(color: AppColors.dark),
    titleTextStyle: TextStyle(
      color: AppColors.dark,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
  ),
  textTheme: AppTextThemes.light,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    tertiary: AppColors.accent,
    surfaceContainerHighest: AppColors.light,
    surface: Color(0xFF111827), // gray-900 background
    onSurface: AppColors.light,
    error: Colors.redAccent,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111827),
    elevation: 1,
    iconTheme: IconThemeData(color: AppColors.light),
    titleTextStyle: TextStyle(
      color: AppColors.light,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
  ),
  textTheme: AppTextThemes.dark,
);
