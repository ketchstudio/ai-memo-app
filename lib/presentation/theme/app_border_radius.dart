import 'package:flutter/material.dart';

class AppBorderRadius {
  AppBorderRadius._();

  static const double _card = 16;
  static const double _button = 12;
  static const double _field = 8;

  static BorderRadius get card => BorderRadius.circular(_card);

  static BorderRadius get button => BorderRadius.circular(_button);

  static BorderRadius get field => BorderRadius.circular(_field);

  // Custom circular radius
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);

  static BorderRadius circle() => BorderRadius.circular(9999);

  // Uniform on each corner
  static BorderRadius all(double radius) =>
      BorderRadius.all(Radius.circular(radius));
}
