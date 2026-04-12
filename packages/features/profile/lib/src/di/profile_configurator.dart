import 'package:core_logic/core_logic.dart';

import 'profile_configurator.config.dart';

@InjectableInit(
  initializerName: 'ProfileAuth',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureProfileInjection() async => ProfileAuth(getIt);