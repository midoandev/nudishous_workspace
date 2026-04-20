import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:sandbox/sandbox.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        final isMain = tabsRouter.activeIndex == 0;
        return AppBar(
          title: Text(isMain ? context.s.sandbox.title : 'Profile'),
          actions: [
            if (!isMain)
              IconButton(
                onPressed: () async {
                  await context.navigateNamedTo(NavConstants.settings);
                },
                icon: Icon(Icons.settings),
              ),
          ],
        );
      },
      routes: [
        SandboxRoute(),
        // DiscoveryRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.bakery_dining),
              label: context.s.sandbox.title,
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
