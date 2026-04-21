class ConfigEnv {
  // Gunakan 'defaultValue' agar tidak 'silent error' saat key tidak ditemukan
  static String get appName => const String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Nudishous (Default)',
  );

  static String get baseUrl => const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://localhost',
  );

  static String get offUser => const String.fromEnvironment('OFF_USER');

  static String get offPassword => const String.fromEnvironment('OFF_PASSWORD');

  /// Tips Pro: Buat fungsi check untuk memastikan semua env terisi saat startup
  static void verifyConfig() {
    assert(appName.isNotEmpty, "APP_NAME is missing in config.json");
    assert(baseUrl.isNotEmpty, "BASE_URL is missing in config.json");
    // Lanjutkan untuk yang lain
  }
}