import 'package:core_logic/core_logic.dart';
import 'profile_router.gr.dart';

@AutoRouterConfig()
class ProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: 'main', page: ProfileRoute.page),
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}