class FoodDto {
  final String code;
  final String name;
  final String? brand;
  final double calories100g;
  final double proteins100g;
  final double carbs100g;
  final double fats100g;
  final String? imageUrl;

  const FoodDto({
    required this.code,
    required this.name,
    this.brand,
    required this.calories100g,
    required this.proteins100g,
    required this.carbs100g,
    required this.fats100g,
    this.imageUrl,
  });
}