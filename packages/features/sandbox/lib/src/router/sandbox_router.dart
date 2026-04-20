import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';

import 'sandbox_router.gr.dart';

@AutoRouterConfig()
class SandboxRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: NavConstants.sandbox, page: SandboxRoute.page),
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}
