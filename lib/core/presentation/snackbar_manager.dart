import 'package:flutter/material.dart';

/// Defines types of snackbars for styling.
enum SnackbarType { info, success, warning, error }

/// Global manager for showing SnackBars from anywhere in the app.
class SnackbarManager {
  /// Key to access the ScaffoldMessenger.
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Shows a SnackBar with the given message and style.
  ///
  /// [message]: Text to display.
  /// [type]: Visual style of the bar.
  /// [duration]: How long to show it.
  /// [actionLabel] & [onAction]: Optional button label and callback.
  static void show({
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    // Build styled SnackBar
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: _backgroundColor(type),
      duration: duration,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onAction ?? () {},
            )
          : null,
    );

    // Remove current one (if any) and show new
    messengerKey.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Maps [SnackbarType] to a background color.
  static Color _backgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.warning:
        return Colors.orange;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.info:
        return Colors.blueGrey;
    }
  }
}
