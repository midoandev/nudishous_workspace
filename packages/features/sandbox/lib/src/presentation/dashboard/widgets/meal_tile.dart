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
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          log.food.imageUrl,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            width: 48,
            height: 48,
            color: context.colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.fastfood_outlined,
              color: context.colorScheme.onSurface.withValues(
                alpha: .5,
              ),
            ),
          ),
        ),
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