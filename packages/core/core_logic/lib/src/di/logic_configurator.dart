import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'logic_configurator.config.dart';

@InjectableInit(
  initializerName: 'initLogic',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureLogicInjection() async => initLogic(getIt);
