import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';

import '../widgets/floating_nav_dock.dart';

@RoutePage()
class MainPage extends StatelessWidget implements AutoRouteWrapper {
  const MainPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(value: getIt<ConnectivityCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AutoTabsScaffold(
            routes: [
              const DashboardRoute(),
              // DiscoveryRoute(),
              const ProfileRoute(),
            ],
            extendBody: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButtonBuilder: (context, tabsRouter) {
              return FloatingNavDock(tabsRouter: tabsRouter);
            },
          ),
        ),
        BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
          builder: (context, status) {
            return ConnectivityBanner(
              isOffline: status == ConnectivityStatus.offline,
            );
          },
        ),
      ],
    );
  }
}
