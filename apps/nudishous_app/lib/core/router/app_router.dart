import 'package:auth/auth.dart';
import 'package:core_logic/core_logic.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  final _sandboxRouter = SandboxRouter();
  final _profileRouter = ProfileRouter();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: DashboardRoute.page, // Halaman utama dengan Bottom Nav
      children: [
        ..._sandboxRouter.routes,
        ..._profileRouter.routes,
      ],
    ),
    // Route untuk login ditaruh di luar Dashboard (Full Screen)
    AutoRoute(path: '/auth', page: AuthRoute.page),
  ];
}