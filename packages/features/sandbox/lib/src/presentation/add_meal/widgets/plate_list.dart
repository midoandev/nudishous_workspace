import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/plate_item.dart';
import '../cubits/add_meal_cubit.dart';

class PlateList extends StatelessWidget {
  final List<PlateItem> plateItems;

  const PlateList({super.key, required this.plateItems});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      // Padding extra bawah agar tidak tertutup summary
      itemCount: plateItems.length,
      itemBuilder: (context, index) {
        final item = plateItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          color: colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.food.imageUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 48,
                                height: 48,
                                color: colorScheme.surfaceContainerHighest,
                                child: Icon(
                                  Icons.fastfood_outlined,
                                  color: colorScheme.onSurface.withValues(
                                    alpha: .5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item.food.name,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () =>
                          context.read<AddMealCubit>().removeFromPlate(index),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.s.sandbox.addMeal.weightLabel,
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.calories.toStringAsFixed(0)} kcal',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Gram Input
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          suffixText: ' g',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                        onChanged: (val) {
                          final weight = double.tryParse(val) ?? 0;
                          context.read<AddMealCubit>().updateWeight(
                            index,
                            weight,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
