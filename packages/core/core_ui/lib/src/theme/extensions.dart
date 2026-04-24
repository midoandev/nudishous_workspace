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

extension MediaQueryExtension on BuildContext {
  // Mengambil seluruh data MediaQuery
  MediaQueryData get mq => MediaQuery.of(this);

  // Pintasan untuk lebar dan tinggi layar
  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;

  // Pintasan untuk padding (misal: status bar)
  double get paddingTop => mq.padding.top;
  double get paddingBottom => mq.padding.bottom;

  // Cek orientasi
  bool get isLandscape => mq.orientation == Orientation.landscape;
}
