// sandbox/domain/entities/weekly_nutrition_entity.dart
import 'package:equatable/equatable.dart';

class DayNutritionSummary extends Equatable {
  final DateTime date;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;

  const DayNutritionSummary({
    required this.date,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
  });

  @override
  List<Object?> get props => [date, totalCalories, totalProtein, totalCarbs, totalFat];
}