import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';



class MealGroupCard extends StatelessWidget {
  final MealGroup group;

  const MealGroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final l = context.s.sandbox;

    // Localized label based on Enum
    final label = switch (group.mealType) {
      MealType.breakfast => l.breakfast,
      MealType.lunch => l.lunch,
      MealType.dinner => l.dinner,
      MealType.snack => l.snack,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildHeader(context, label),
          const Divider(height: 1),
          ...group.items.map((item) => _buildMealItem(context, item)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text(
                "${group.timestamp.hour}:${group.timestamp.minute.toString().padLeft(2, '0')}",
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${group.totalCalories.toInt()} kcal",
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "P: ${group.totalCalories.toInt()}g  C: ${group.totalCarbs.toInt()}g  F: ${group.totalFat.toInt()}g",
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(BuildContext context, MealLogEntity item) {
    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(item.food.imageUrl, width: 40, height: 40, fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Icon(Icons.fastfood, size: 20)),
      ),
      title: Text(item.food.name),
      subtitle: Text("${item.weightGram.toInt()}g"),
      trailing: Text("${((item.weightGram / 100) * item.food.calories100g).toInt()} kcal"),
    );
  }
}