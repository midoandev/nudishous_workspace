import 'package:flutter/material.dart';
import '../../../core_ui.dart';
import '../app_text_style.dart';

class AppBarStyles {
  AppBarStyles._();

  static AppBarTheme get theme => AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.surface,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: false,
    titleTextStyle: AppTextStyle.titleLarge,
    iconTheme: IconThemeData(color: AppColors.surface),
  );
}
