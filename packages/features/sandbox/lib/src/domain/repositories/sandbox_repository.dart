import 'package:sandbox/src/domain/entities/meal_entry.dart';

import '../entities/plate_item.dart';

abstract class SandboxRepository {
  Future<List<MealEntry>> searchFood(String query);

  Future<void> saveMeal(List<PlateItem> item);
}
