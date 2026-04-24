import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class BuildInfoState extends StatelessWidget {
  final IconData icon; final String label; final String? subLabel;
  const BuildInfoState({super.key, required this.icon, required this.label, this.subLabel});

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: context.colorScheme.outlineVariant),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              if (subLabel != null) ...[
                const SizedBox(height: 8),
                Text(
                  subLabel!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall,
                ),
              ]
            ],
          ),
        ),
      );
    }
}
