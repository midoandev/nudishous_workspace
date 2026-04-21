import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'openfood_configurator.config.dart';

@InjectableInit(
  initializerName: 'initOpenfood',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureOpenfoodInjection() async => initOpenfood(getIt);
