import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'empty_state_widget.dart';
import 'meal_group_card.dart';

class BuildMealHistorySection extends StatelessWidget {
  final List<MealGroup> logs;
  final Function() addMeal;

  const BuildMealHistorySection({
    super.key,
    required this.logs,
    required this.addMeal,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.s.dashboard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (logs.isEmpty) ...[
          EmptyStateWidget(onPressInput: addMeal),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.meals_today,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              // Link "Lihat Semua" jika nanti datanya sudah banyak
              IconButton(onPressed: addMeal, icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(height: 12),
          // Menggunakan ListView.builder di dalam Column dengan shrinkWrap
          // atau langsung spread operator jika jumlahnya tidak masif.
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => MealGroupCard(group: logs[index]),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyMealState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_outlined,
            size: 48,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            context.s.sandbox.emptyState.title,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
