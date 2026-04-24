import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/sandbox.dart';

import '../../add_meal/widgets/mid_end_float_fab_location.dart';
import '../widgets/calorie_gauge.dart';
import '../widgets/macro_item.dart';
import '../widgets/meal_tile.dart';

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
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: const MidEndFloatFabLocation(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigasi ke SearchPage menggunakan AutoRoute
            context.router.push(const AddMealRoute());
          },
          label: Text(context.s.sandbox.addMeal.title),
          icon: const Icon(Icons.add),
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return switch (state) {
              DashboardLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              DashboardLoaded(nutrition: final data, dailyGoal: final goal) =>
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // 1. Header Gauge
                      CalorieGauge(consumed: data.totalCalories, goal: goal),

                      const SizedBox(height: 32),

                      // 2. Macro Breakdown (Protein, Carbs, Fat)
                      buildMacroRow(context, data: data),

                      const SizedBox(height: 32),

                      // 3. Daily Meals List
                      buildMealList(context, logs: data.logs),
                    ],
                  ),
                ),
              DashboardError(message: final msg) => Center(child: Text(msg)),
            };
          },
        ),
      ),
    );
  }

  Widget buildMacroRow(
    BuildContext context, {
    required DailyNutritionEntity data,
  }) {
    return Row(
      children: [
        Expanded(
          child: MacroItem(
            label: context.s.dashboard.protein,
            // Nanti ganti s.dashboard.protein
            value: data.totalProtein,
            goal: 77,
            // Nanti ambil dari PreferenceService
            icon: Icons.egg_outlined,
            color: Colors.orange,
          ),
        ),
        Expanded(
          child: MacroItem(
            label: context.s.dashboard.carbs,
            value: data.totalCarbs,
            goal: 250,
            icon: Icons.bakery_dining_outlined,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: MacroItem(
            label: context.s.dashboard.fat,
            value: data.totalFat,
            goal: 60,
            icon: Icons.opacity,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget buildMealList(
    BuildContext context, {
    required List<MealLogEntity> logs,
  }) {
    if (logs.isEmpty) {
      return const Center(child: Text("Belum ada makanan hari ini"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.s.dashboard.meals_today,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Kita map data logs menjadi widget list item
        ...logs.map((log) => MealTile(log: log)),
      ],
    );
  }
}
