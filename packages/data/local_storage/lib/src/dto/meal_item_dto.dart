class MealItemDto {
  final int id;
  final double weightGram;

  // Food fields (dari JOIN)
  final String foodCode;
  final String foodName;
  final String? foodBrand;
  final double calories100g;
  final double proteins100g;
  final double carbs100g;
  final double fats100g;
  final String? imageUrl;

  const MealItemDto({
    required this.id,
    required this.weightGram,
    required this.foodCode,
    required this.foodName,
    this.foodBrand,
    required this.calories100g,
    required this.proteins100g,
    required this.carbs100g,
    required this.fats100g,
    this.imageUrl,
  });
}
