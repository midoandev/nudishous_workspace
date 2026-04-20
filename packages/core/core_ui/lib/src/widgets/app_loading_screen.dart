// packages/core/core_ui/lib/src/widgets/app_loading_screen.dart
import 'package:flutter/material.dart';

class AppLoadingScreen extends StatelessWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Kita gunakan Scaffold agar bisa menutupi seluruh layar (Full Screen)
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
