import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

sealed class AppTheme {
  // The defined light theme.
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent, // Terracotta untuk aksi sekunder
      surfaceContainer: AppColors.surfaceContainer,
      surface: AppColors.surface,
      onPrimary: Colors.white,
    ),

    // Customizing AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Customizing Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Customizing Floating Action Button (Good for the "Add" button)
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
    ),

    // Customizing Card (Untuk item makanan di piring)
    cardTheme: CardThemeData(
      color: AppColors.surfaceContainer,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Customizing Text
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.textMain),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
  );
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      // Kita kunci warna utama agar tetap sesuai brand identity
      primary: AppColors.primaryLight, // Gunakan versi terang di BG gelap
      secondary: AppColors.accent,      // Tetap gunakan Terracotta
      surfaceContainer: const Color(0xFF1A1C18), // Dark Greenish Grey (bukan hitam pekat)
      surface: const Color(0xFF1A1C18),
      onPrimary: AppColors.primaryDark,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A1C18),
      foregroundColor: AppColors.primaryLight,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF23261F), // Sedikit lebih terang dari background
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Color(0xFFE2E3DC)), // Off-white agar tidak silau
      bodyMedium: TextStyle(color: Color(0xFFC6C8BE)),
    ),
  );
}
