import 'package:core_i18n/core_i18n.dart';
import 'package:flutter/material.dart';

extension DateFormatterX on BuildContext {
  String getMonthName(int month) {
    final c = s.common;
    return switch (month) {
      1 => c.month_january,
      2 => c.month_february,
      3 => c.month_march,
      4 => c.month_april,
      5 => c.month_may,
      6 => c.month_june,
      7 => c.month_july,
      8 => c.month_august,
      9 => c.month_september,
      10 => c.month_october,
      11 => c.month_november,
      12 => c.month_december,
      _ => "",
    };
  }

  String getDayName(int weekday) {
    final c = s.common;
    return switch (weekday) {
      DateTime.monday => c.day_monday,
      DateTime.tuesday => c.day_tuesday,
      DateTime.wednesday => c.day_wednesday,
      DateTime.thursday => c.day_thursday,
      DateTime.friday => c.day_friday,
      DateTime.saturday => c.day_saturday,
      DateTime.sunday => c.day_sunday,
      _ => "",
    };
  }

  /// Output: Senin, 27 April 2026
  String formatFullDate(DateTime date) {
    return "${getDayName(date.weekday)}, ${date.day} ${getMonthName(date.month)} ${date.year}";
  }
}