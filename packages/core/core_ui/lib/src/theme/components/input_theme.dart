import 'package:flutter/material.dart';

import 'app_text_style.dart';

class InputStyles {
  InputStyles._();

  static InputDecorationTheme get theme => InputDecorationTheme(
    filled: true,
    // fillColor: AppColors..withOpacity(0.5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1),
    ),
    hintStyle: AppTextStyle.bodyMedium,
    labelStyle: AppTextStyle.bodyMedium,
  );
}
