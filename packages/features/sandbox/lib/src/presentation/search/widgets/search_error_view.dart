import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SearchMessageView extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onRetry;

  const SearchMessageView({
    super.key,
    required this.icon,
    required this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: context.colorScheme.outline),
          ),
          const SizedBox(height: 24),
          // Text(
          //   title,
          //   style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          //   textAlign: TextAlign.center,
          // ),
          // const SizedBox(height: 8),
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.s.sandbox.search.try_again),
            ),
          ],
        ],
      ),
    );
  }
}