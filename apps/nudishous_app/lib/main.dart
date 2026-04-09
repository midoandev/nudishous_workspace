import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/sandbox.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NudishousApp());
}

class NudishousApp extends StatelessWidget {
  const NudishousApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    return MaterialApp(
      title: config.appTitle,
      debugShowCheckedModeBanner: config.flavor == Flavor.dev,
      theme:AppTheme.light,
      darkTheme: AppTheme.dark,
      home: BlocProvider(
        create: (context) => SandboxCubit(),
        child: const SandboxPage(),
      ),
    );
  }
}