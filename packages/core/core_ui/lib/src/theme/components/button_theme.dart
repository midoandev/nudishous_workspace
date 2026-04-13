import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_style.dart';

class ButtonStyles {
  ButtonStyles._();

  static FilledButtonThemeData get filledButton => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      // backgroundColor: AppColors.primary,
      // foregroundColor: AppColors.onPrimary,
      minimumSize: const Size(double.infinity, 52), // full width, tinggi 52
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTextStyle.labelLarge,
    ),
  );

  static OutlinedButtonThemeData get outlinedButton => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      side: const BorderSide(color: AppColors.primary),
      textStyle: AppTextStyle.labelLarge,
    ),
  );

  static TextButtonThemeData get textButton => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppTextStyle.labelLarge,
    ),
  );
}