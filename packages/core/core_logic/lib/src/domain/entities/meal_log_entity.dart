import 'package:equatable/equatable.dart';

import 'food_entity.dart';

class MealLogEntity extends Equatable {
  final int? id; // Untuk Isar
  final FoodEntity food;
  final double weightGram;
  final DateTime eatenAt;

  const MealLogEntity({
    this.id,
    required this.food,
    required this.weightGram,
    required this.eatenAt,
  });

  // Helper untuk hitung kalori berdasarkan berat yang dimakan
  double get totalCalories => (weightGram / 100) * food.calories100g;

  @override
  List<Object?> get props => [id, food, weightGram, eatenAt];
}