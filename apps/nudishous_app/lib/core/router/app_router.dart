import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';
import 'package:settings/settings.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: NavConstants.splash,
      page: SplashRoute.page,
      initial: true
    ),
    AutoRoute(
      path: NavConstants.main,
      page: MainRoute.page, // Halaman utama dengan Bottom Nav
      // children: [, ...ProfileRouter().routes],
      children: [
        AutoRoute(path: NavConstants.sandbox, page: DashboardRoute.page),
        AutoRoute(path: NavConstants.profile, page: ProfileRoute.page),
      ],
    ),
    ...SandboxRouter().routes,
    ...ProfileRouter().routes,
    ...AuthRouter().routes,
    ...SettingsRouter().routes,
  ];
}
