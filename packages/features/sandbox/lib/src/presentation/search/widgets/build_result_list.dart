import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'build_nutri_score_badge.dart';

class BuildResultList extends StatelessWidget {
  final List<FoodEntity> list;
  final Function(FoodEntity food) onSelect;

  const BuildResultList(
      {super.key, required this.list, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: list.length,
      separatorBuilder: (context, index) =>
      const Divider(height: 1, thickness: 0.1),
      itemBuilder: (context, index) {
        final food = list[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: food.imageUrl.isNotEmpty == true
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                food.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.fastfood),
              ),
            )
                : const Icon(Icons.fastfood),
          ),
          title: Row( // <-- Gunakan Row di sini
            children: [
              Expanded(
                child: Text(
                  food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              // PANGGIL DI SINI: Badge Nutri-Score
              BuildNutriScoreBadge(score:food.nutriscore),
            ],
          ),
          subtitle: Text(
            "${food.calories100g.toInt()} ${context.s.sandbox.kcal} / 100g",
            style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.primary),
          ),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: () => onSelect(food),
        );
      },
    );
  }
}