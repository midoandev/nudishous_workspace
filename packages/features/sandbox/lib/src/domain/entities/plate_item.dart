import 'package:sandbox/src/domain/entities/meal_entry.dart';

class PlateItem {
  final MealEntry food;
  final double weightGrams;

  const PlateItem({
    required this.food,
    this.weightGrams = 100.0,
  });

  // Formula Nutrisi: (base / 100) * weight
  double get calories => (food.calories * weightGrams) / 100;

  // Membantu immutability di Cubit nanti
  PlateItem copyWith({double? weightGrams}) => PlateItem(
    food: food,
    weightGrams: weightGrams ?? this.weightGrams,
  );
}