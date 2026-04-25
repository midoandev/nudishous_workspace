import 'package:core_logic/core_logic.dart';
import 'package:equatable/equatable.dart';


class MealLogEntity extends Equatable {
  final int? id; // Untuk Isar
  final FoodEntity food;
  final double weightGram;
  final DateTime eatenAt;
  final MealType mealType;

  const MealLogEntity({
    this.id,
    required this.food,
    required this.weightGram,
    required this.eatenAt,
    required this.mealType,
  });

  // Helper untuk hitung kalori berdasarkan berat yang dimakan
  double get totalCalories => (weightGram / 100) * food.calories100g;

  @override
  List<Object?> get props => [id, food, weightGram, eatenAt, mealType];
}