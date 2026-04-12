import 'package:core_logic/core_logic.dart';

import 'network_configurator.config.dart';

@InjectableInit(
  initializerName: 'initNetwork',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureNetworkInjection() async =>
    initNetwork(getIt);