import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class AppBarStyles {
  static AppBarTheme theme(ColorScheme colors) =>
      const AppBarTheme(elevation: 1, scrolledUnderElevation: 2, centerTitle: false);

  static ActionIconThemeData actionIconTheme(ColorScheme colors) =>
      ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(FeatherIcons.arrowLeft),
      );
}
