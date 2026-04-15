import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  final PreferenceService _pref;

  ThemeCubit(this._pref) : super(ThemeMode.light) {
    _initTheme();
  }

  void _initTheme() {
    final savedMode = _pref.getThemeMode();

    if (savedMode.isEmpty) {
      // Deteksi awal: Jika HP sedang Dark, set ke Dark. Jika tidak, Light.
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final initialMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      setThemeMode(initialMode);
    } else {
      emit(savedMode == 'dark' ? ThemeMode.dark : ThemeMode.light);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;
    await _pref.setThemeMode(mode.name);
    emit(mode);
  }

}
