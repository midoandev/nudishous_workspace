import '../entities/food_entity.dart';
import '../entities/meal_log_entity.dart';
import '../entities/meal_type.dart';

abstract class IMealRepository {
  Future<List<MealLogEntity>> getLogsByDate(DateTime date);

  Future<void> saveMeal({
    required FoodEntity food,
    required double weight,
    required DateTime date,
    required MealType mealType,
  });
}
