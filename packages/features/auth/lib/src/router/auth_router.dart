import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';

import 'auth_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: NavConstants.auth, page: AuthRoute.page),
  ];
}
