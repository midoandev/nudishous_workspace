import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/daily_nutrition_entity.dart';
import 'calorie_arc_painter.dart';

class BuildSliverHeader extends StatelessWidget {
  final DailyNutritionEntity data;
  final DateTime selectedDate;
  final Function(DateTime)? updateDate;

  const BuildSliverHeader({super.key,required this.data, required this.selectedDate, this.updateDate});

  @override
  Widget build(BuildContext context) {
    final s = context.s.sandbox;
    final consumed = data.totalCalories;
    final remaining = data.remainingCalories;
    final displayRemaining = remaining < 0 ? 0 : remaining.toInt();

    final isOverBudget = remaining < 0;
    final double progress = (consumed / data.calorieGoal).clamp(0.0, 1.0);
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
                      context.formatFullDate(DateTime.now()),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                // IconButton.filledTonal(
                //   onPressed: () => _selectDate(context),
                //   icon: const Icon(Icons.calendar_month_rounded),
                // ),
              ],
            ),
            const SizedBox(height: 32),

            // Calorie Gauge with Text
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150, // Konsisten dengan header
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
                  bottom: 0,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: context.colorScheme.copyWith(
              primary: context.colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate && context.mounted) {
      updateDate?.call(picked);
    }
  }

}
