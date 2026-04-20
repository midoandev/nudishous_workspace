import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import 'ui_configurator.config.dart';

@InjectableInit(
  initializerName: 'initUi',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureUiInjection() async => initUi(getIt);
