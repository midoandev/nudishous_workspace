import 'package:equatable/equatable.dart';

enum MealType { breakfast, lunch, dinner, snack }

class MealEntry extends Equatable {
  final String id;
  final String name;
  final int calories;
  final int protein; // dalam gram
  final int carbs;
  final int fat;
  final String imageUrl;
  final MealType type;
  final double grams;

  const MealEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.imageUrl,
    required this.type,
    this.grams = 100.0,
  });

  // Rumus: (grams / 100) * nilai_dasar
  double get calculatedCalories => (grams / 100) * calories;

  double get calculatedProtein => (grams / 100) * protein;

  MealEntry copyWith({double? grams}) => MealEntry(
    id: id,
    name: name,
    calories: calories,
    protein: protein,
    grams: grams ?? this.grams,
    carbs: carbs,
    fat: fat,
    imageUrl: '',
    type: type,
  );

  @override
  List<Object?> get props => [id, grams];
}
