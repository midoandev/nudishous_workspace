import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
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
      appBarBuilder: (context, tabsRouter) {
        final isMain = tabsRouter.activeIndex == 0;
        if (isMain) return null;
        return AppBar(
          title: Text(context.s.profile.title),
          actions: [
            IconButton(
              onPressed: () async {
                await context.navigateToPath(NavConstants.settings);
              },
              icon: Icon(Icons.settings),
            ),
          ],
        );
      },
      routes: [
        DashboardRoute(),
        // DiscoveryRoute(),
        ProfileRoute(),
      ],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonBuilder: (context, tabsRouter) {
        return FloatingNavDock(tabsRouter: tabsRouter);
      },
    );
  }
}
