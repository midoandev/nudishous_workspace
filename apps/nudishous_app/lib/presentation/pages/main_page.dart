import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';

import '../widgets/floating_nav_dock.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const DashboardRoute(),
        // DiscoveryRoute(),
        const ProfileRoute(),
      ],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonBuilder: (context, tabsRouter) {
        return FloatingNavDock(tabsRouter: tabsRouter);
      },
    );
  }
}
