// packages/data/local_storage/lib/src/db/tables/

// 1. Master data makanan
import 'package:drift/drift.dart';

class Foods extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  RealColumn get calories100g => real()();
  RealColumn get proteins100g => real()();
  RealColumn get carbs100g => real()();
  RealColumn get fats100g => real()();
  TextColumn get imageUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {code};
}

// 2. Sesi makan (grouping)
class MealSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get eatenAt => dateTime()();   // waktu sesi
  TextColumn get mealType => text()();           // breakfast/lunch/dinner/snack
  TextColumn get notes => text().nullable()();   // catatan opsional
}

// 3. Item dalam sesi makan
class MealItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(MealSessions, #id)();
  TextColumn get foodCode => text().references(Foods, #code)();
  RealColumn get weightGram => real()();
}