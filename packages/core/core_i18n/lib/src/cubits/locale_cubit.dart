import 'package:core_logic/core_logic.dart'; // Import injectable & dartz/equatable
import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

@lazySingleton
class LocaleCubit extends Cubit<Locale> {
  final PreferenceService _pref;

  LocaleCubit(this._pref) : super(I18n.defaultLocale) {
    _initLocale();
  }

  void _initLocale() {
    final savedLang = _pref.getLanguage();

    if (savedLang.isEmpty) {
      final systemLang = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      // Cek dukungan, jika tidak ada pakai default (en)
      final supported = I18n.supportedLocales.any((l) => l.languageCode == systemLang);
      final initialLocale = supported ? Locale(systemLang) : I18n.defaultLocale;
      setLocale(initialLocale);
    } else {
      I18n.load(savedLang);
      emit(Locale(savedLang));
    }
  }

  void setLocale(Locale locale) {
    _pref.setLanguage(locale.languageCode);
    I18n.loadFromLocale(locale);
    emit(locale);
  }
}