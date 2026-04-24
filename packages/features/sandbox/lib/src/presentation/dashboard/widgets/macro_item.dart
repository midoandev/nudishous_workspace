import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MacroItem extends StatelessWidget {
  final String label;
  final double value;
  final double goal;
  final IconData icon;
  final Color color;

  const MacroItem({super.key,
    required this.label,
    required this.value,
    required this.goal,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            children: [
              TextSpan(text: '${value.toInt()}'),
              TextSpan(
                text: '/${goal.toInt()}g',
                style: context.textTheme.labelSmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}