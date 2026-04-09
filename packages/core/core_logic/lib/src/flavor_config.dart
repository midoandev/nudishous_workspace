enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  final String appTitle;

  static FlavorConfig? _instance;

  FlavorConfig._internal(this.flavor, this.apiBaseUrl, this.appTitle);

  static const _baseUrl = 'id.midosaurus.nudishous';
  static const _appName = 'id.midosaurus.nudishous';
  // static const _offUser = 'midosaurus_dev';
  // static const _offPassword = 'rahasia_midosaurus';

  static void set(Flavor flavor) {
    _instance = switch (flavor) {
      Flavor.dev => FlavorConfig._internal(
        Flavor.dev,
        _baseUrl, // Bisa ganti ke server dev jika ada
        '$_appName Dev',
      ),
      Flavor.prod => FlavorConfig._internal(Flavor.prod, _baseUrl, _appName),
    };
  }

  static FlavorConfig get instance => _instance!;
}
