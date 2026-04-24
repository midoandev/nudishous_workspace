import 'package:core_logic/core_logic.dart';
import 'package:drift/drift.dart';

import '../db/app_database.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMealRepository)
class MealRepository implements IMealRepository {
  final AppDatabase _db;

  MealRepository(this._db);

  @override
  Future<List<MealLogEntity>> getLogsByDate(DateTime date) async {
    final query =
        _db.select(_db.mealLogs).join([
          innerJoin(_db.foods, _db.foods.code.equalsExp(_db.mealLogs.foodCode)),
        ])..where(
          _db.mealLogs.eatenAt.year.equals(date.year) &
              _db.mealLogs.eatenAt.month.equals(date.month) &
              _db.mealLogs.eatenAt.day.equals(date.day),
        );

    final results = await query.get();

    return results.map((row) {
      final meal = row.readTable(_db.mealLogs);
      final food = row.readTable(_db.foods);

      return MealLogEntity(
        id: meal.id,
        weightGram: meal.weightGram,
        eatenAt: meal.eatenAt,
        food: FoodEntity(
          code: food.code,
          name: food.name,
          brand: food.brand ?? '',
          calories100g: food.calories100g,
          proteins100g: food.proteins100g,
          carbs100g: food.carbs100g,
          fats100g: food.fats100g,
          imageUrl: food.imageUrl ?? '',
        ),
      );
    }).toList();
  }

  @override
  Future<void> saveMeal({
    required FoodEntity food,
    required double weight,
    required DateTime date,
  }) async {
    // Gunakan transaction supaya jika satu gagal, semua dibatalkan
    await _db.transaction(() async {
      // 1. Masukkan atau Perbarui data Master Makanan
      // Kita gunakan Companion untuk menangani field yang bisa null
      await _db
          .into(_db.foods)
          .insertOnConflictUpdate(
            FoodsCompanion.insert(
              code: food.code,
              name: food.name,
              brand: Value(food.brand),
              calories100g: food.calories100g,
              proteins100g: food.proteins100g,
              carbs100g: food.carbs100g,
              fats100g: food.fats100g,
              imageUrl: Value(food.imageUrl),
            ),
          );

      // 2. Masukkan entri ke Log Makan
      await _db
          .into(_db.mealLogs)
          .insert(
            MealLogsCompanion.insert(
              foodCode: food.code,
              weightGram: weight,
              eatenAt: date,
            ),
          );
    });
  }
}
