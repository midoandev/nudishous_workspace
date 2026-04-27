import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/food_entity.dart';

class BuildResultList extends StatelessWidget {
  final List<FoodEntity> list;
  final Function(FoodEntity food) onSelect;

  const BuildResultList({
    super.key,
    required this.list,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: list.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 0.1),
      itemBuilder: (context, index) {
        final food = list[index];
        final calDisplay = food.calories100g % 1 == 0
            ? food.calories100g.toInt().toString()
            : food.calories100g.toStringAsFixed(1);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: ImageCard(url: food.imageUrl, size: 50),
          title: Text(
            food.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "$calDisplay ${context.s.sandbox.kcal} / 100g",
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: () => onSelect(food),
        );
      },
    );
  }
}
