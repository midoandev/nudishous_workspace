import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'messages.i69n.dart';
import 'messages_id.i69n.dart';

class I18n {
  static Messages _current = const Messages();

  static Messages get s => _current;

  static void loadFromLocale(Locale locale) {
    load(locale.languageCode);
  }

  static void load(String locale) {
    switch (locale) {
      case 'id':
        _current = const Messages_id();
        break;
      default:
        _current = const Messages();
    }
  }

  static const supportedLocales = [Locale('en'), Locale('id')];

  // static final localizationsDelegates =  FlutterLocalization.instance.localizationsDelegates;

  // ✅ GUNAKAN INI: Standar resmi Flutter
  static final localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const defaultLocale = Locale('en');
}
