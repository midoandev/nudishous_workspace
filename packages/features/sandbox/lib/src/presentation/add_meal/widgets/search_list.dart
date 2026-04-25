import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

class SearchList extends StatelessWidget {
  final List<MealEntry> searchResults;
  final Function(MealEntry) selectMeal;

  const SearchList({super.key, required this.searchResults,required this.selectMeal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: searchResults.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final food = searchResults[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              food.imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 48, height: 48,
                color: colorScheme.surfaceContainerHighest,
                child: Icon(Icons.fastfood_outlined, color: colorScheme.onSurface.withValues(alpha: .5)),
              ),
            ),
          ),
          title: Text(
            food.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('${food.calories.toStringAsFixed(0)} ${context.s.sandbox.kcal} / 100g'),
          trailing: IconButton(
            icon: Icon(Icons.add_circle, color: colorScheme.primary),
            onPressed: () => selectMeal(food),
          ),
        );
      },
    );
  }
}
