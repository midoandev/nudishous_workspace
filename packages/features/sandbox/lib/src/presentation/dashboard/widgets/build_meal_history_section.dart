import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/meal_session_entity.dart';
import '../../widgets/meal_group_card.dart';
import 'empty_state_widget.dart';

class BuildMealHistorySection extends StatelessWidget {
  final List<MealSessionEntity> logs;
  final Function() addMeal;
  final Function() seeAll;

  const BuildMealHistorySection({
    super.key,
    required this.logs,
    required this.seeAll,
    required this.addMeal,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.s.sandbox;

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
              IconButton(onPressed: addMeal, icon: Icon(Icons.add_circle, color: context.colorScheme.primary)),
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

          if (logs.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: seeAll,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: context.colorScheme.outlineVariant),
                  ),
                  child: Text(context.s.meals.view_all),
                ),
              ),
            )
        ],
      ],
    );
  }
}
