import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/sandbox.dart';

void main() {
  runApp(const NudishousApp());
}

class NudishousApp extends StatelessWidget {
  const NudishousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nudishous',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      // Membungkus SandboxPage dengan Cubit-nya
      home: BlocProvider(
        create: (context) => SandboxCubit(),
        child: const SandboxPage(),
      ),
    );
  }
}