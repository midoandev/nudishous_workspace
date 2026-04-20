import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';

import 'settings_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class SettingsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: NavConstants.settings, page: SettingsRoute.page),
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}
