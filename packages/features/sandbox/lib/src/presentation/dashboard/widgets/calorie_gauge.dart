// packages/features/dashboard/lib/src/ui/widgets/calorie_gauge.dart

import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'calorie_arc_painter.dart';

class CalorieGauge extends StatelessWidget {
  final double consumed;
  final double goal;

  const CalorieGauge({super.key, required this.consumed, required this.goal});

  @override
  Widget build(BuildContext context) {
    // Logika Persentase
    final double progress = (consumed / goal).clamp(0.0, 1.0);
    final double remaining = (goal - consumed).clamp(0.0, goal);

    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 250,
          child: CustomPaint(
            painter: CalorieArcPainter(
              progress: progress,
              backgroundColor: context.colorScheme.surfaceContainerHighest,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${remaining.toInt()}',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(context.s.profile.guest_subtitle), // Pakai i18n s.dashboard.remaining
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Color _getGaugeColor(BuildContext context, double progress) {
  //   if (progress > 0.9) return Colors.red;
  //   if (progress > 0.7) return Colors.orange;
  //   return context.colorScheme.primary;
  // }
}