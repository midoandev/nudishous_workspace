import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/sandbox.dart';

import '../widgets/empty_state_widget.dart';
import '../widgets/energy_total_card.dart';
import '../widgets/header_section.dart';
import '../widgets/meal_card.dart';

@RoutePage()
class DashboardPage extends StatelessWidget implements AutoRouteWrapper {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardUpdated>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      const SizedBox(height: 24),
                      const EnergyTotalCard(totalKcal: 986),
                      const SizedBox(height: 32),

                      if (state.item.isEmpty)
                        EmptyStateWidget(
                          onPressInput: () =>
                              context.router.push(AddMealRoute()),
                        )
                      else
                        MealCard(
                          title: context.s.sandbox.breakfast,
                          items: state.item,
                        ),
                      const SizedBox(height: 100),
                      // Spacer agar tidak tertutup dock
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => DashboardCubit(), child: this);
  }
}
