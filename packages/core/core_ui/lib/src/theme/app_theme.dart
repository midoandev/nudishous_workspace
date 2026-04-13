import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/theme/components/app_bar_styles.dart';
import 'package:flutter/material.dart';

import 'app_text_style.dart';
import 'components/bottom_nav_styles.dart';
import 'components/button_theme.dart';
import 'components/input_theme.dart';

abstract final class AppTheme {

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surfaceContainer: AppColors.surfaceContainer,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,              // ✅ tambah
      onSurface: AppColors.textMain,          // ✅ tambah
      onSurfaceVariant: AppColors.textSecondary, // ✅ tambah
    ),

    appBarTheme: AppBarStyles.theme,
    navigationBarTheme: BottomNavStyles.theme,
    filledButtonTheme: ButtonStyles.filledButton,
    outlinedButtonTheme: ButtonStyles.outlinedButton,
    textButtonTheme: ButtonStyles.textButton,
    inputDecorationTheme: InputStyles.theme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52), // ✅ full width
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
    ),

    cardTheme: CardThemeData(
      color: AppColors.surfaceContainer,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: AppTextStyle.displayLarge,
      headlineLarge: AppTextStyle.headlineLarge,
      headlineMedium: AppTextStyle.headlineMedium,
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      bodyLarge: AppTextStyle.bodyLarge,
      bodyMedium: AppTextStyle.bodyMedium,
      labelLarge: AppTextStyle.labelLarge,
      labelMedium: AppTextStyle.labelMedium,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      secondary: AppColors.accent,
      surfaceContainer: const Color(0xFF23261F),
      surface: const Color(0xFF1A1C18),
      onPrimary: const Color(0xFF1A2500),   // ✅ fix kontras
      onSecondary: Colors.white,             // ✅ tambah
      onSurface: const Color(0xFFE2E3DC),   // ✅ tambah
      onSurfaceVariant: const Color(0xFFC6C8BE), // ✅ tambah
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A1C18),
      foregroundColor: AppColors.primaryLight,
      elevation: 0,
      centerTitle: true,
    ),

    // ✅ Tambahkan di dark theme juga
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: const Color(0xFF1A2500),
        minimumSize: const Size(double.infinity, 52),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF23261F),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Color(0xFFE2E3DC)),
      bodyMedium: TextStyle(color: Color(0xFFC6C8BE)),
    ),
  );
}