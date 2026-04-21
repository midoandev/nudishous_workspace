import 'package:auto_route/auto_route.dart';

import 'profile_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class ProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}
