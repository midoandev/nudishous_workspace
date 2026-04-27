import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/meal_type.dart';
import '../cubits/add_meal_state.dart';

class BuildMealTypeSelector extends StatelessWidget {
  final AddMealState state;
  final Function(Set<MealType> newSelection) onSelectionChanged;
  const BuildMealTypeSelector({super.key, required this.state, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {

      final l = context.s.sandbox;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SegmentedButton<MealType>(
          segments: [
            ButtonSegment(
                value: MealType.breakfast,
                label: Text(l.breakfast),
                icon: const Icon(Icons.wb_sunny_outlined)
            ),
            ButtonSegment(
                value: MealType.lunch,
                label: Text(l.lunch),
                icon: const Icon(Icons.light_mode_outlined)
            ),
            ButtonSegment(
                value: MealType.dinner,
                label: Text(l.dinner),
                icon: const Icon(Icons.nightlight_outlined)
            ),
            ButtonSegment(
                value: MealType.snack,
                label: Text(l.snack),
                icon: const Icon(Icons.bakery_dining)
            ),
          ],
          selected: {state.selectedMealType},
          onSelectionChanged: onSelectionChanged,
          showSelectedIcon: false,
        ),
      );
    }
  }