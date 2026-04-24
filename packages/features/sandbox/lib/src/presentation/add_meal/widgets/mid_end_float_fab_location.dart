import 'package:flutter/material.dart';

// 1. Buat kelas lokasi kustom Anda
class MidEndFloatFabLocation extends FloatingActionButtonLocation {
  const MidEndFloatFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // scaffoldGeometry berisi info ukuran Scaffold, content, dll.

    // Hitung posisi X:
    // Lebar scaffold - setengah lebar FAB - margin kanan
    final double fabX = scaffoldGeometry.scaffoldSize.width -150;

    // Hitung posisi Y:
    // Setengah tinggi scaffold - setengah tinggi FAB
    final double fabY = scaffoldGeometry.scaffoldSize.height / 1.32;

    return Offset(fabX, fabY);
  }
}