import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class ProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}
