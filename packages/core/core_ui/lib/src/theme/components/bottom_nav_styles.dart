import 'package:flutter/material.dart';
import 'app_text_style.dart';

class BottomNavStyles {
  BottomNavStyles._();

  static NavigationBarThemeData get theme => NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTextStyle.labelMedium;
      }
      return AppTextStyle.labelMedium;
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData();
      }
      return const IconThemeData();
    }),
  );
}
