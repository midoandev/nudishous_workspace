import 'package:core_logic/core_logic.dart';
import 'package:equatable/equatable.dart';

class PlateItem extends Equatable {
  final String id; // ID unik untuk item di piring (misal: timestamp)
  final FoodEntity food;
  final double weightGrams;

  const PlateItem({
    required this.id,
    required this.food,
    this.weightGrams = 100.0,
  });

  // Getters untuk kalkulasi nutrisi otomatis berdasarkan berat
  // Formula: (nilai_per_100g / 100) * berat_input
  double get totalCalories => (food.calories100g / 100) * weightGrams;
  double get totalProtein => (food.proteins100g / 100) * weightGrams;
  double get totalCarbs => (food.carbs100g / 100) * weightGrams;
  double get totalFat => (food.fats100g / 100) * weightGrams;

  PlateItem copyWith({
    double? weightGrams,
  }) =>
      PlateItem(
        id: id,
        food: food,
        weightGrams: weightGrams ?? this.weightGrams,
      );

  @override
  List<Object?> get props => [id, food, weightGrams];
}