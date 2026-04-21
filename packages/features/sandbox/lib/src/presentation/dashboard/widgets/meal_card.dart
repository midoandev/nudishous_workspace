import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/meal_entry.dart';

class MealCard extends StatelessWidget {
  final String title;
  final List<MealEntry> items;

  const MealCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          ],
        ),
        ...items.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: textTheme.titleMedium),
                    Text('${item.calories} KCAL', style: textTheme.bodySmall),
                  ],
                ),
              ),
              _buildMacroInfo(context, item),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildMacroInfo(BuildContext context, MealEntry item) {
    final style = Theme.of(context).textTheme.bodySmall;
    final color = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        _macroDot(context, '${item.protein}g', context.s.sandbox.macros.protein),
        _macroDot(context, '${item.carbs}g', context.s.sandbox.macros.carbs),
        _macroDot(context, '${item.fat}g', context.s.sandbox.macros.fat),
      ],
    );
  }

  Widget _macroDot(BuildContext context, String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.orange)),
        ],
      ),
    );
  }
}