import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalorieArcPainter extends CustomPainter {
  final double progress; // Nilai 0.0 sampai 1.0
  final Color backgroundColor;

  CalorieArcPainter({
    required this.progress,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Tentukan Titik Pusat (Center) dan Jari-jari (Radius)
    // Kita ingin pusatnya ada di tengah secara horizontal, dan di paling bawah secara vertikal
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // 2. Tentukan Area Gambar (Rect)
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 3. Konfigurasi Background Arc (Abu-abu/Kosong)
    final paintBackground = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // 4. Konfigurasi Progress Arc dengan Gradient
    // SweepGradient mulai menghitung dari 0 radian (sisi kanan/jam 3)
    final paintProgress = Paint()
      ..shader = const SweepGradient(
        colors: [Colors.greenAccent, Colors.yellowAccent, Colors.redAccent],
        stops: [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: math.pi, // Hanya setengah lingkaran
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // 5. Gambar Busur Background
    // StartAngle = pi (mulai dari kiri/jam 9), SweepAngle = pi (berputar 180 derajat ke kanan)
    canvas.drawArc(rect, math.pi, math.pi, false, paintBackground);

    // 6. Gambar Busur Progress
    // Panjang busur tergantung pada nilai progress (0.0 - 1.0)
    canvas.drawArc(rect, math.pi, math.pi * progress, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CalorieArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}