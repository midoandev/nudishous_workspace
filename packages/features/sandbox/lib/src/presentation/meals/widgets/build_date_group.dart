import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/src/presentation/widgets/meal_group_card.dart';

import '../../../domain/entities/meal_session_entity.dart';

class BuildDateGroup extends StatelessWidget {
  final DateTime date;
  final List<MealSessionEntity> listData;

  const BuildDateGroup({super.key, required this.listData, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Text(
            context.formatFullDate(date), // Pakai extension format harian kita
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: listData.map((log) => MealGroupCard(group: log)).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
