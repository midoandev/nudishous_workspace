import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  // Default ke System (mengikuti setting HP)
  ThemeCubit() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    if (state == mode) return;
    emit(mode);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }
}
