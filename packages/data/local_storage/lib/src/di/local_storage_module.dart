// packages/data/local_storage/lib/src/di/sandbox_module.dart
import 'package:core_logic/core_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@module
abstract class LocalStorageModule {
  // SharedPreferences perlu async → di-register manual di main.dart
  // Di sini kita ambil dari getIt yang sudah di-register

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );
}