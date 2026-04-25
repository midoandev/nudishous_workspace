import 'package:drift/drift.dart';

class Foods extends Table {
  TextColumn get code => text()(); // Barcode sebagai Primary Key
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

class MealLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foodCode => text().references(Foods, #code)();
  RealColumn get weightGram => real()();
  DateTimeColumn get eatenAt => dateTime()();
  TextColumn get mealType => text()();
}