class FoodItem {
  final String barcode;
  final String name;
  final String? imageUrl;
  final double calories;
  final double carbs;
  final double protein;
  final double fat;

  FoodItem({
    required this.barcode,
    required this.name,
    this.imageUrl,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });
}