import 'package:core_logic/core_logic.dart'; // Import injectable & dartz/equatable
import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';

@lazySingleton
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(I18n.defaultLocale) {
    _initLocale();
  }

  void _initLocale() {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    // 3. Cek apakah didukung oleh I18n
    if (I18n.supportedLocales.any((l) => l.languageCode == systemLocale.languageCode)) {
      setLocale(Locale(systemLocale.languageCode));
    } else {
      setLocale(I18n.defaultLocale);
    }
  }

  void setLocale(Locale locale) {
    I18n.loadFromLocale(locale);
    emit(locale);
  }
}