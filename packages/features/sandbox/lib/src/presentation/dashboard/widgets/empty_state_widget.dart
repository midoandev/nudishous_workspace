import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final Function() onPressInput;
  const EmptyStateWidget({super.key,required this.onPressInput});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Icon(Icons.no_food_outlined, size: 80, color: colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(
            context.s.sandbox.emptyState.title,
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            context.s.sandbox.emptyState.subtitle,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onPressInput,
            icon: const Icon(Icons.add),
            label: Text(context.s.sandbox.emptyState.button),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}