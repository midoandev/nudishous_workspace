import 'package:core_logic/core_logic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage/src/constants/pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class PreferenceService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  const PreferenceService(this._prefs, this._secureStorage);

  // Token
  Future<void> saveToken(String token) =>
      _secureStorage.write(key: PrefConstant.authToken.name, value: token);

  Future<String?> getToken() =>
      _secureStorage.read(key: PrefConstant.authToken.name);

  Future<void> clearToken() =>
      _secureStorage.delete(key: PrefConstant.authToken.name);

  // User preference biasa
  Future<void> setOnboarded(bool value) async =>
      await _prefs.setBool(PrefConstant.isOnBoarded.name, value);

  bool get isOnboarded =>
      _prefs.getBool(PrefConstant.isOnBoarded.name) ?? false;

  String getLanguage() => _prefs.getString(PrefConstant.language.name) ?? '';

  Future<void> setLanguage(String mode) =>
      _prefs.setString(PrefConstant.language.name, mode);

  String getThemeMode() => _prefs.getString(PrefConstant.themeMode.name) ?? '';

  Future<void> setThemeMode(String mode) =>
      _prefs.setString(PrefConstant.themeMode.name, mode);

  String getCurrentUser() =>
      _prefs.getString(PrefConstant.currentUser.name) ?? '';

  Future<void> setCurrentUser(String mode) =>
      _prefs.setString(PrefConstant.currentUser.name, mode);
}
