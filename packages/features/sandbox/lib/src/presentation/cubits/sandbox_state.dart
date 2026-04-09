import 'package:core_logic/core_logic.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final double calories;
  final double protein;
  final double grams;

  const FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    this.grams = 100.0,
  });

  // Rumus: (grams / 100) * nilai_dasar
  double get calculatedCalories => (grams / 100) * calories;
  double get calculatedProtein => (grams / 100) * protein;

  FoodItem copyWith({double? grams}) => FoodItem(
    id: id, name: name, calories: calories, protein: protein,
    grams: grams ?? this.grams,
  );

  @override
  List<Object?> get props => [id, grams];
}

class SandboxUpdated extends BaseState {
  final List<FoodItem> piring;

  const SandboxUpdated(this.piring);

  double get totalCalories => piring.fold(0, (sum, item) => sum + item.calculatedCalories);
  double get totalProtein => piring.fold(0, (sum, item) => sum + item.calculatedProtein);

  @override
  List<Object?> get props => [piring];
}