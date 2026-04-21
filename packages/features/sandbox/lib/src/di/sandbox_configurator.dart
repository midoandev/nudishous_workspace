import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

// import 'injection.module.dart';
import 'sandbox_configurator.config.dart';

@InjectableInit(
  initializerName: 'initSandbox',
  preferRelativeImports: true,
  asExtension: false,
  // externalPackageModulesBefore: [
  //   SandboxPackageModule
  // ]
)
Future<void> configureSandboxInjection() async => initSandbox(getIt);
