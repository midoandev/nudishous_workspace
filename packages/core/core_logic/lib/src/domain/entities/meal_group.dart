import 'meal_type.dart';
import 'meal_log_entity.dart';

class MealGroup {
  final MealType mealType;
  final List<MealLogEntity> items;
  final DateTime timestamp;

  MealGroup({
    required this.mealType,
    required this.items,
    required this.timestamp,
  });
  //
  // Aggregate getters for the group
  double get totalCalories => items.fold(0, (sum, item) => sum + item.food.calories100g);
  double get totalProtein => items.fold(0, (sum, item) => sum + item.food.proteins100g);
  double get totalCarbs => items.fold(0, (sum, item) => sum + item.food.carbs100g);
  double get totalFat => items.fold(0, (sum, item) => sum + item.food.fats100g);
}