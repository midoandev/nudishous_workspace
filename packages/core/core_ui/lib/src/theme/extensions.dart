import 'package:flutter/material.dart';

extension ThemeExtention on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  // Contoh jika Anda punya custom spacing atau color
  bool get isDarkMode => theme.brightness == Brightness.dark;
}

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  bool get isMobile => screenWidth < 600;
}
