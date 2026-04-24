import 'package:flutter/material.dart';

import 'app_text_style.dart';

class InputStyles {
  InputStyles._();

  static InputDecorationTheme theme(ColorScheme colors) => InputDecorationTheme(
    filled: true,
    // suffixIconColor: colors.onPrimary,
    prefixIconColor: colors.primary.withValues(alpha: .7),
    // fillColor: AppColors..withOpacity(0.5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.primaryContainer),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.shadow, width: .5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1,color: colors.primaryFixedDim),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: colors.error),
    ),
    hintStyle: AppTextStyle.bodyMedium,
    labelStyle: AppTextStyle.bodyMedium,
  );
}
