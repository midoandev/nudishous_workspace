// sandbox/domain/entities/daily_nutrition_entity.dart
import 'package:equatable/equatable.dart';
import 'meal_session_entity.dart';

class DailyNutritionEntity extends Equatable {
  // Summary nutrisi
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;

  // Goals (dari user profile/settings)
  final double calorieGoal;

  // Riwayat sesi makan (maks 10 untuk home)
  final List<MealSessionEntity> recentSessions;
  final int totalSessionCount; // untuk tahu apakah ada "lihat semua"

  const DailyNutritionEntity({
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.calorieGoal,
    required this.recentSessions,
    required this.totalSessionCount,
  });

  // ✅ Computed properties — logika di entity, bukan di UI
  double get remainingCalories => calorieGoal - totalCalories;
  bool get isOverGoal => totalCalories > calorieGoal;
  double get progressPercent => (totalCalories / calorieGoal).clamp(0.0, 1.0);
  bool get hasMoreSessions => totalSessionCount > recentSessions.length;

  @override
  List<Object?> get props => [
    totalCalories, totalProtein, totalCarbs, totalFat,
    calorieGoal, recentSessions, totalSessionCount,
  ];
}