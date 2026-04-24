import 'package:core_logic/src/domain/entities/food_entity.dart';

import '../entities/meal_log_entity.dart';

abstract class IMealRepository {
  Future<List<MealLogEntity>> getLogsByDate(DateTime date);

  Future<void> saveMeal({
    required FoodEntity food,
    required double weight,
    required DateTime date,
  });
}
