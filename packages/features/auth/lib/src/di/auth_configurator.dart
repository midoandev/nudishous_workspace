import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'auth_configurator.config.dart';

@InjectableInit(
  initializerName: 'initAuth',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureAuthInjection() async => initAuth(getIt);
