import 'package:auto_route/auto_route.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:nudishous/core/router/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // 1. Jalankan inisialisasi (cek auth, load pref, dll)
    // Kita panggil AuthCubit untuk cek status login/guest
    // await context.read<AuthCubit>().initApp();
    await Future.delayed(const Duration(seconds: 1));
    // 2. Jika sudah selesai, pindah ke Dashboard
    if (mounted) {
      context.router.replace(const MainRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Center(child: AppAssets.images.icLauncher.image(),)
    );
  }
}
