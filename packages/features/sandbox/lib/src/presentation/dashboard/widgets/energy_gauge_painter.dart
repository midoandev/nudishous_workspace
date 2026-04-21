import 'dart:math';

import 'package:flutter/material.dart';

class EnergyGaugePainter extends CustomPainter {
  final Color primaryColor;
  final Color backgroundColor;

  EnergyGaugePainter({
    required this.primaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paintBase = Paint()
      ..color = backgroundColor // Menggunakan ColorScheme.surfaceContainerHighest
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final paintProgress = Paint()
      ..color = primaryColor // Menggunakan ColorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, pi, false, paintBase);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, pi * 0.6, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}