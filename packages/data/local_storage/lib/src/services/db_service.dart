// packages/data/local_storage/lib/src/datasources/meal_local_datasource.dart
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../db/app_database.dart';
import '../dto/food_dto.dart';
import '../dto/meal_item_dto.dart';
import '../dto/meal_session_dto.dart';

// ✅ Return tipe Drift (DB model), bukan domain entity!
@lazySingleton
class DbService {
  final AppDatabase _db;

  DbService(this._db);

  Future<List<MealSessionDto>> getSessionsByDate({required DateTime start, DateTime? endDate}) async {
    // final start = DateTime(date.year, date.month, date.day) ;
    final end = endDate ?? start
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    // 1. Ambil semua sesi di tanggal ini
    final sessions = await (_db.select(
      _db.mealSessions,
    )..where((s) => s.eatenAt.isBetweenValues(start, end))).get();

    // 2. Untuk setiap sesi, ambil items-nya
    final result = await Future.wait(
      sessions.map((session) async {
        final itemsQuery = _db.select(_db.mealItems).join([
          innerJoin(
            _db.foods,
            _db.foods.code.equalsExp(_db.mealItems.foodCode),
          ),
        ])..where(_db.mealItems.sessionId.equals(session.id));

        final rows = await itemsQuery.get();

        final items = rows.map((row) {
          final item = row.readTable(_db.mealItems);
          final food = row.readTable(_db.foods);

          return MealItemDto(
            id: item.id,
            weightGram: item.weightGram,
            foodCode: food.code,
            foodName: food.name,
            foodBrand: food.brand,
            calories100g: food.calories100g,
            proteins100g: food.proteins100g,
            carbs100g: food.carbs100g,
            fats100g: food.fats100g,
            imageUrl: food.imageUrl,
          );
        }).toList();

        return MealSessionDto(
          id: session.id,
          eatenAt: session.eatenAt,
          mealType: session.mealType,
          notes: session.notes,
          items: items,
        );
      }),
    );

    return result;
  }

  Future<int> createSession({
    required DateTime eatenAt,
    required String mealType,
    String? notes,
  }) => _db
      .into(_db.mealSessions)
      .insert(
        MealSessionsCompanion.insert(
          eatenAt: eatenAt,
          mealType: mealType,
          notes: Value(notes),
        ),
      );

  Future<void> addItemToSession({
    required int sessionId,
    required FoodDto food,
    required double weightGram,
  }) async {
    await _db.transaction(() async {
      // Upsert food master
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

      // Insert meal item
      await _db
          .into(_db.mealItems)
          .insert(
            MealItemsCompanion.insert(
              sessionId: sessionId,
              foodCode: food.code,
              weightGram: weightGram,
            ),
          );
    });
  }

  Future<void> deleteItem(int itemId) =>
      (_db.delete(_db.mealItems)..where((i) => i.id.equals(itemId))).go();

  Future<void> deleteSession(int sessionId) =>
      (_db.delete(_db.mealSessions)..where((s) => s.id.equals(sessionId))).go();
}
