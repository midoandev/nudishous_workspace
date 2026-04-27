import 'package:equatable/equatable.dart';

import 'food_entity.dart';

class MealItemEntity extends Equatable {
  final int id;
  final FoodEntity food;
  final double weightGram;

  const MealItemEntity({
    required this.id,
    required this.food,
    required this.weightGram,
  });

  // Kalori item ini berdasarkan berat
  double get calories => (food.calories100g * weightGram) / 100;
  double get proteins => (food.proteins100g * weightGram) / 100;
  double get carbs => (food.carbs100g * weightGram) / 100;
  double get fats => (food.fats100g * weightGram) / 100;

  @override
  List<Object?> get props => [id, food, weightGram];
}