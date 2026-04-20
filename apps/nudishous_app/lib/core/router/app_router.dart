import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';
import 'package:settings/settings.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: SplashRoute.page,
      initial: true
    ),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page, // Halaman utama dengan Bottom Nav
      children: [...SandboxRouter().routes, ...ProfileRouter().routes],
    ),
    ...AuthRouter().routes,
    ...SettingsRouter().routes,
  ];
}
