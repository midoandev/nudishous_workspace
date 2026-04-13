import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
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
          title: Text(isMain ? 'Dashboard' : 'Profile'),
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
          // Tips Senior: Gunakan warna dari AppTheme yang sudah kita buat sebelumnya
          selectedItemColor: context.colorScheme.primary,
          unselectedItemColor: context.colorScheme.onSurfaceVariant,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bakery_dining),
              label: 'Sandbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}