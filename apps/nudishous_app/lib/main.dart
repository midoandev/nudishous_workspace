import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NudishousApp());
}

class NudishousApp extends StatelessWidget {
  NudishousApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    return MaterialApp.router(
      title: config.appTitle,
      debugShowCheckedModeBanner: config.flavor == Flavor.dev,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: _appRouter.config(),
    );
  }
}
