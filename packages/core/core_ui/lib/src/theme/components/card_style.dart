import 'package:flutter/material.dart';

class CardStyle {
  CardStyle._();

  static CardThemeData get theme => CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
