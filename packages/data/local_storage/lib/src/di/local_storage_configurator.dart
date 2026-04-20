import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'local_storage_configurator.config.dart';

@InjectableInit(
  initializerName: 'initLocalStorage',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureLocalStorageInjection() async => initLocalStorage(getIt);
