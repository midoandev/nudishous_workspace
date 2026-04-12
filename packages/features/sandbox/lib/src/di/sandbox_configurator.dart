import 'package:core_logic/core_logic.dart';

import 'sandbox_configurator.config.dart';

@InjectableInit(
  initializerName: 'initSandbox',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureSandboxInjection() async => initSandbox(getIt);