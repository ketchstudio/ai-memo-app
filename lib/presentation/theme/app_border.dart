import 'package:flutter/material.dart';

class AppBorder {
  AppBorder._(); // Prevent instantiation

  static const double _thin = 1.0;
  static const double _thick = 1.5;

  /// Default card border (light gray)
  static Border card([Color? color]) =>
      Border.all(color: color ?? Colors.grey.shade200, width: _thin);

  /// Outline border (e.g., for input fields)
  static Border outline([Color? color]) =>
      Border.all(color: color ?? Colors.grey.shade300, width: _thin);

  /// Thin border side (e.g., for InputDecoration)
  static BorderSide thin([Color? color]) =>
      BorderSide(color: color ?? Colors.grey.shade300, width: _thin);

  /// Thick border side
  static BorderSide thick([Color? color]) =>
      BorderSide(color: color ?? Colors.grey.shade400, width: _thick);

  /// Custom solid border side
  static BorderSide solid(Color color, {double width = 1.0}) =>
      BorderSide(color: color, width: width);

  /// Custom border with individual sides
  static Border only({
    Color color = Colors.grey,
    double width = _thin,
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return Border(
      top: top ? BorderSide(color: color, width: width) : BorderSide.none,
      bottom: bottom ? BorderSide(color: color, width: width) : BorderSide.none,
      left: left ? BorderSide(color: color, width: width) : BorderSide.none,
      right: right ? BorderSide(color: color, width: width) : BorderSide.none,
    );
  }
}
