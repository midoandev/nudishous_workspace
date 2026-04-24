import 'package:auto_route/auto_route.dart';
import 'package:sandbox/src/presentation/search/pages/search_page.dart';

import '../presentation/add_meal/pages/add_meal_page.dart';
import 'sandbox_router.gr.dart';

@AutoRouterConfig()
class SandboxRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: AddMealPage.namePath, page: AddMealRoute.page),
    AutoRoute(path: SearchPage.namePath, page: SearchRoute.page),
  ];
}
