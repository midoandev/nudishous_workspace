import 'package:core_logic/core_logic.dart';

import 'auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: 'main', page: AuthRoute.page, initial: true),
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}