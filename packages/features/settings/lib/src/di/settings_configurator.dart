import 'package:core_logic/core_logic.dart';

import 'settings_configurator.config.dart';

@InjectableInit(
  initializerName: 'SettingsAuth',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureSettingsInjection() async => SettingsAuth(getIt);