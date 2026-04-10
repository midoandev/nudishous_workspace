import 'package:core_logic/core_logic.dart';
import 'sandbox_router.gr.dart';

@AutoRouterConfig()
class SandboxRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: 'main', page: SandboxRoute.page, initial: true),
    // AutoRoute(path: 'detail', page: FoodDetailRoute.page),
  ];
}