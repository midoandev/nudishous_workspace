import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/app_database.dart';

@module
abstract class LocalStorageModule {
  @preResolve // Penting agar SharedPreferences siap sebelum App jalan
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage =>
      const FlutterSecureStorage(aOptions: AndroidOptions());

  @singleton
  AppDatabase get db => AppDatabase();
}
