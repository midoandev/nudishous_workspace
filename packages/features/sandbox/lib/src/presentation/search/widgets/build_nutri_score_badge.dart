import 'package:flutter/material.dart';

class BuildNutriScoreBadge extends StatelessWidget {
  final String score;

  const BuildNutriScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
      final Color color = switch (score) {
        'A' => Colors.green,
        'B' => Colors.lightGreen,
        'C' => Colors.yellow,
        'D' => Colors.orange,
        'E' => Colors.red,
        _ => Colors.grey,
      };

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          score,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      );
    }
}
