// MealSessionEntity — satu sesi makan
import 'package:equatable/equatable.dart';

import 'meal_type.dart';
import 'meal_item_entity.dart';

class MealSessionEntity extends Equatable {
  final int id;
  final DateTime eatenAt;
  final MealType mealType;
  final List<MealItemEntity> items; // ← list item di dalamnya
  final String? notes;

  const MealSessionEntity({
    required this.id,
    required this.eatenAt,
    required this.mealType,
    required this.items,
    this.notes,
  });

  // Total kalori sesi ini
  double get totalCalories => items.fold(0, (sum, item) => sum + item.calories);

  double get totalCarbs => items.fold(0, (sum, item) => sum + item.carbs);

  double get totalFat => items.fold(0, (sum, item) => sum + item.fats);
  double get totalProtein => items.fold(0, (sum, item) => sum + item.proteins);

  @override
  List<Object?> get props => [id, eatenAt, mealType, items, notes];
}
