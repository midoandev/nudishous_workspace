import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';

import '../entities/food_entity.dart';
import '../entities/meal_session_entity.dart';
import '../entities/meal_type.dart';
import '../entities/plate_item.dart';

abstract class SandboxRepository {
  Future<List<FoodEntity>> searchProducts(String query);

  Future<Either<Failure, List<MealSessionEntity>>> getSessionsByDate(DateTime date, {DateTime? endDate});
  Future<Either<Failure, void>> saveMealSession({
    required List<PlateItem> items,
    required DateTime eatenAt,
    required MealType mealType,
  });

  Future<Either<Failure, void>> deleteSession(int sessionId);

}
