import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/sandbox.dart';

import 'widgets/build_macro_section.dart';
import 'widgets/build_meal_history_section.dart';
import 'widgets/build_sliver_header.dart';

@RoutePage()
class DashboardPage extends StatelessWidget implements AutoRouteWrapper {
  const DashboardPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: const MidEndFloatFabLocation(),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     await context.router.push(const AddMealRoute());
      //
      //     if (context.mounted) {
      //       await context.read<DashboardCubit>().fetchDashboardData();
      //     }
      //   },
      //   label: Text(context.s.sandbox.addMeal.title),
      //   icon: const Icon(Icons.add_rounded),
      //   elevation: 4,
      // ),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return switch (state) {
              DashboardLoading() => const Center(child: AppLoadingScreen()),
              DashboardError(message: final msg) => Center(child: Text(msg)),
              DashboardLoaded(nutrition: final data, dailyGoal: final goal) =>
                CustomScrollView(
                  slivers: [
                    // 1. Header & Date Navigator
                    BuildSliverHeader(goal: goal, data: data),

                    // 2. Body Content
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          // Macro Progress Cards
                          BuildMacroSection(data: data),

                          const SizedBox(height: 32),

                          // Meal History List
                          BuildMealHistorySection(
                            logs: state.mealGroups,
                            addMeal: () async {
                              await context.router.push(const AddMealRoute());
                              if (context.mounted) {
                                await context
                                    .read<DashboardCubit>()
                                    .fetchDashboardData();
                              }
                            },
                          ),

                          // Extra space for FAB
                          const SizedBox(height: 100),
                        ]),
                      ),
                    ),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}
