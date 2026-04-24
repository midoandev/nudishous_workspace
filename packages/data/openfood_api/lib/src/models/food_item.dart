import 'package:core_logic/core_logic.dart';

class FoodItem {
  final String? code;
  final String? productName;
  final String? brands;
  final String? quantity; // Total isi (misal: 250ml)
  final String? imageFrontSmallUrl; // Untuk list (hemat bandwidth)
  final String? imageFrontUrl; // Untuk detail
  final String? servingSize; // Ukuran saji (misal: 1 serving 200ml)
  final double? servingQuantity; // Angka ukuran saji (200.0)
  final String? nutriscore; // Grade A-E
  final String? ecoscore; // Grade A-E
  final int? novaGroup; // Tingkat pemrosesan (1-4)
  final Nutriments? nutriments;

  FoodItem({
    this.code,
    this.productName,
    this.brands,
    this.quantity,
    this.imageFrontSmallUrl,
    this.imageFrontUrl,
    this.servingSize,
    this.servingQuantity,
    this.nutriscore,
    this.ecoscore,
    this.novaGroup,
    this.nutriments,
  });

  // Mapper ke Domain Entity yang Suci
  FoodEntity toEntity() {
    return FoodEntity(
      // Handle Barcode Null: Jika null, pakai timestamp + nama produk agar unik
      code: code ?? "no-code-${DateTime.now().millisecondsSinceEpoch}",
      name: productName ?? 'Unknown Product',
      brand: brands ?? 'Generic Brand',
      imageUrl: imageFrontSmallUrl ?? imageFrontUrl ?? '',

      // Nutrisi Dasar (per 100g/ml)
      calories100g: _calculateCalories().toDouble(),
      proteins100g: nutriments?.proteins100G ?? 0,
      carbs100g: nutriments?.carbohydrates100G ?? 0,
      fats100g: nutriments?.fat100G ?? 0,

      // Data Tambahan Pro
      servingSize: servingSize ?? '',
      servingQuantity: servingQuantity ?? 0,
      nutriscore: nutriscore?.toUpperCase() ?? '?',
      ecoscore: ecoscore?.toUpperCase() ?? '?',
      novaGroup: novaGroup ?? 0,
    );
  }

  num _calculateCalories() {
    if (nutriments == null) return 0;
    // Prioritas kcal, fallback ke kJ
    if (nutriments!.energyKcal100G != null) return nutriments!.energyKcal100G!;
    if (nutriments!.energyKj100G != null) return nutriments!.energyKj100G! / 4.184;
    return 0;
  }
}

class Nutriments {
  double? energyKcal100G;
  double? energyKj100G;
  double? proteins100G;
  double? fat100G;
  double? saturatedFat100G;
  double? carbohydrates100G;
  double? sugars100G;
  double? calcium100G;
  double? cholesterol100G;
  double? sodium100G;
  double? salt100G;
  double? fiber100G;

  Nutriments({
    this.energyKcal100G,
    this.energyKj100G,
    this.proteins100G,
    this.fat100G,
    this.saturatedFat100G,
    this.carbohydrates100G,
    this.sugars100G,
    this.calcium100G,
    this.cholesterol100G,
    this.sodium100G,
    this.salt100G,
    this.fiber100G,
  });

  Map<String, dynamic> toJson() => {
    "energy-kcal_100g": energyKcal100G,
    "energy-kj_100g": energyKj100G,
    "proteins_100g": proteins100G,
    "fat_100g": fat100G,
    "saturated-fat_100g": saturatedFat100G,
    "carbohydrates_100g": carbohydrates100G,
    "sugars_100g": sugars100G,
    "calcium_100g": calcium100G,
    "cholesterol_100g": cholesterol100G,
    "sodium_100g": sodium100G,
    "salt_100g": salt100G,
    "fiber_100g": fiber100G,
  };
}
