import 'package:core_logic/core_logic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class PreferenceService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  const PreferenceService(this._prefs, this._secureStorage);

  // Token
  Future<void> saveToken(String token) =>
      _secureStorage.write(key: 'auth_token', value: token);

  Future<String?> getToken() => _secureStorage.read(key: 'auth_token');

  Future<void> clearToken() async =>
      await _secureStorage.delete(key: 'auth_token');

  // User preference biasa
  Future<void> setOnboarded(bool value) =>
      _prefs.setBool('is_onboarded', value);

  bool get isOnboarded => _prefs.getBool('is_onboarded') ?? false;
}
