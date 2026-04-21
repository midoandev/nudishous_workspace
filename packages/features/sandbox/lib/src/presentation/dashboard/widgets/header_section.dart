import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            context.s.sandbox.greeting,
            style: context.textTheme.headlineMedium?.copyWith(
              // fontWeight: FontWeight.bold,
              fontSize: 32,
              letterSpacing: 1.24
              // color: context.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.calendar_today_outlined),
        ),
      ],
    );
  }
}
