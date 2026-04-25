import 'package:core_logic/core_logic.dart';
import 'package:equatable/equatable.dart';

class DailyNutritionEntity extends Equatable {
  final List<MealLogEntity> logs;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;

  const DailyNutritionEntity({
    required this.logs,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
  });

  // Factory untuk inisialisasi data kosong (misal saat baru buka app)
  factory DailyNutritionEntity.empty() {
    return const DailyNutritionEntity(
      logs: [],
      totalCalories: 0,
      totalProtein: 0,
      totalCarbs: 0,
      totalFat: 0,
    );
  }

  @override
  List<Object?> get props => [logs, totalCalories, totalProtein, totalCarbs, totalFat];
}