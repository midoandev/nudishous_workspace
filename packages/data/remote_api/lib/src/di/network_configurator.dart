import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';

import 'network_configurator.config.dart';

@InjectableInit(
  initializerName: 'initNetwork',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [
    PreferenceService, // ← suppress warning, resolve dari luar
  ],
)
Future<void> configureNetworkInjection() async => initNetwork(getIt);
