import 'config_env.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String? apiBaseUrl;
  final String? appTitle;
  final String? offUser;
  final String? offPassword;

  static FlavorConfig? _instance;

  FlavorConfig._internal(this.flavor, {
    this.apiBaseUrl,
    this.appTitle,
    this.offUser,
    this.offPassword});

  static void set(Flavor flavor) {
    final effectiveName = flavor == Flavor.dev
        ? '${ConfigEnv.appName} Dev'
        : ConfigEnv.appName;
    final effectiveUrl = flavor == Flavor.dev
        ? '${ConfigEnv.baseUrl}.dev'
        : ConfigEnv.baseUrl;

    ConfigEnv.verifyConfig();

    print('dsfklmds $flavor $effectiveUrl');
    _instance = FlavorConfig._internal(
        flavor,
        appTitle: effectiveName,
        apiBaseUrl: effectiveUrl,
        offPassword: ConfigEnv.offPassword,
        offUser: ConfigEnv.offUser
    );
  }

  static FlavorConfig get instance => _instance!;
}
