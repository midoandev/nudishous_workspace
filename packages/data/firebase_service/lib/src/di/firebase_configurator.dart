// packages/data/firebase_service/lib/src/di/firebase_configurator.dart
import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';
import 'firebase_configurator.config.dart';

@InjectableInit(
  initializerName: 'initFirebase',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureFirebaseInjection() async => initFirebase(getIt);