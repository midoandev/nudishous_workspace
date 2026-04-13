import 'package:flutter/material.dart';

extension ThemeExtention on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}