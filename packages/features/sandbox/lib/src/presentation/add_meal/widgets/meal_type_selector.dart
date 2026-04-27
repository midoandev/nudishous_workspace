import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/meal_type.dart';

class MealTypeSelector extends StatelessWidget {
  final MealType selectedType;
  final Function(MealType) onSelected;

  const MealTypeSelector({
    super.key,
    required this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.s.sandbox.addMeal.selectType,
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: MealType.values.map((type) {
              final isSelected = selectedType == type;
              final label = _getLabel(context, type);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) onSelected(type);
                  },
                  selectedColor: context.colorScheme.primaryContainer,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? context.colorScheme.onPrimaryContainer
                        : context.colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.outlineVariant,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getLabel(BuildContext context, MealType type) {
    final d = context.s.sandbox;
    return switch (type) {
      MealType.breakfast => d.breakfast,
      MealType.lunch => d.lunch,
      MealType.dinner => d.dinner,
      MealType.snack => d.snack,
    };
  }
}
