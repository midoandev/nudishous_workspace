import 'package:flutter/material.dart';

class ElevatedButtonStyle {
  ElevatedButtonStyle._();

  static ElevatedButtonThemeData get theme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 52),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
