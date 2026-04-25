import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class BuildMacroSection extends StatelessWidget {
  final DailyNutritionEntity data;

  const BuildMacroSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          _buildMacroCard(context, context.s.dashboard.protein, data.totalProtein, 77, Colors.orange, Icons.egg_rounded),
          const SizedBox(width: 12),
          _buildMacroCard(context, context.s.dashboard.carbs, data.totalCarbs, 250, Colors.blue, Icons.bakery_dining_rounded),
          const SizedBox(width: 12),
          _buildMacroCard(context, context.s.dashboard.fat, data.totalFat, 60, Colors.green, Icons.water_drop_rounded),
        ],
      );
    }
  }

Widget _buildMacroCard(BuildContext context, String label, double val, double goal, Color color, IconData icon) {
  final progress = (val / goal).clamp(0.0, 1.0);
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: context.textTheme.labelSmall),
          Text("${val.toInt()}g", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(value: progress, color: color, backgroundColor: color.withValues(alpha: 0.1), minHeight: 4),
          ),
        ],
      ),
    ),
  );
}
