import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'locale_configurator.config.dart';

@InjectableInit(
  initializerName: 'initLocale',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureLocaleInjection() async => initLocale(getIt);
