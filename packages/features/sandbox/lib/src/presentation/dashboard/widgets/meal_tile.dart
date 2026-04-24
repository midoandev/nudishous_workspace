import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MealTile extends StatelessWidget {
  final MealLogEntity log;

  const MealTile({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.restaurant, size: 20), // Nanti pakai Image.network(log.food.imageUrl)
      ),
      title: Text(
        log.food.name,
        style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text("${log.weightGram.toInt()}g • ${log.eatenAt.hour}:${log.eatenAt.minute}"),
      trailing: Text(
        "${log.totalCalories.toInt()} kcal",
        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
      ),
    );
  }
}