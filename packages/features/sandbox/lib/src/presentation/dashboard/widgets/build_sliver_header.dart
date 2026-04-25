import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'calorie_arc_painter.dart';

class BuildSliverHeader extends StatelessWidget {
  final DailyNutritionEntity data;
  final double goal;

  const BuildSliverHeader({super.key, required this.data, required this.goal});

  @override
  Widget build(BuildContext context) {
    final s = context.s.dashboard;
    final consumed = data.totalCalories;
    final remaining = goal - consumed;
    final displayRemaining = remaining < 0 ? 0 : remaining.toInt();

    final isOverBudget = remaining < 0;
    final double progress = (consumed / goal).clamp(0.0, 1.0);
    final gaugeColor = isOverBudget ? Colors.red : context.colorScheme.primary;

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            // User Greeting & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo, Mid!",
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sabtu, 25 April",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month_rounded),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Calorie Gauge with Text
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120, // Konsisten dengan header
                  width: MediaQueryExtension(context).screenWidth * .65,
                  child: CustomPaint(
                    painter: CalorieArcPainter(
                      progress: progress,
                      backgroundColor: gaugeColor,
                      // accentColor: consumed > goal ? Colors.red : context.colorScheme.primary,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$displayRemaining',
                        style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: isOverBudget
                              ? Colors.red
                              : context.colorScheme.primary,
                          letterSpacing: -1,
                        ),
                      ),
                      Text(
                        s.remaining.toUpperCase(),
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.outline,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
