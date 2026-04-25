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
              Text(
                label,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.av_timer_rounded, size: 8),
                  const SizedBox(width: 4),
                  Text(
                    "${group.timestamp.hour}:${group.timestamp.minute
                        .toString()
                        .padLeft(2, '0')}",
                    style: context.textTheme.labelSmall,
                  ),
                ],
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
              Row(
                children: [
                  _buildIconText(context, icon: Icons.egg_rounded,
                      color: Colors.orange,
                      text: '${group.totalCalories.toInt()}'),
                  _buildIconText(context, color: Colors.blue,
                      icon: Icons.bakery_dining_rounded,
                      text: '${group.totalCarbs.toInt()}'),
                  _buildIconText(context, color: Colors.green,
                      icon: Icons.water_drop_rounded,
                      text: '${group.totalFat.toInt()}')
                ],
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
      leading: ImageCard(url: item.food.imageUrl),
      title: Text(item.food.name),
      subtitle: Text("${item.weightGram.toInt()}g"),
      trailing: Text(
        "${((item.weightGram / 100) * item.food.calories100g).toInt()} kcal",
      ),
    );
  }

  Widget _buildIconText(BuildContext context,
      {required IconData icon, required Color color, required String text}) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Icon(icon, color: color, size: 8),
        const SizedBox(width: 4),
        Text(
          "${text}g",
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
