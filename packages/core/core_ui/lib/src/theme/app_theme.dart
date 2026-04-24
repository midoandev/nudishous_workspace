import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/theme/components/app_bar_styles.dart';
import 'package:core_ui/src/theme/components/card_style.dart';
import 'package:core_ui/src/theme/components/elevated_button_style.dart';
import 'package:flutter/material.dart';

import 'components/button_theme.dart';
import 'components/input_theme.dart';

abstract final class AppTheme {
  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: brightness == Brightness.light
          ? AppColors.primary
          : AppColors.primaryDark,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      appBarTheme: AppBarStyles.theme(colorScheme),
      actionIconTheme: AppBarStyles.actionIconTheme(colorScheme),
      // navigationBarTheme: BottomNavStyles.theme,
      filledButtonTheme: ButtonStyles.filledButton,
      outlinedButtonTheme: ButtonStyles.outlinedButton,
      textButtonTheme: ButtonStyles.textButton,
      inputDecorationTheme: InputStyles.theme(colorScheme),
      elevatedButtonTheme: ElevatedButtonStyle.theme,
      cardTheme: CardStyle.theme,
      // textTheme: AppTextStyle.theme,
    );
  }

  static ThemeData get light => _buildTheme(Brightness.light);

  static ThemeData get dark => _buildTheme(Brightness.dark);
}
