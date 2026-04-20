import 'package:openfoodfacts/openfoodfacts.dart';

/// Extension untuk membersihkan data mentah dari API
extension ProductSanitizer on Product {
  double get safeCalories =>
      nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0.0;

  double get safeProtein =>
      nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0;

  double get safeCarbs =>
      nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
      0.0;

  double get safeFat =>
      nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0;

  String get safeImageUrl => imageFrontUrl ?? "";

  String get safeName => productName ?? "Produk Tanpa Nama";
}
