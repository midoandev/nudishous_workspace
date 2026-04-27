import 'package:openfood_api/openfood_api.dart';

class FoodItemDto {
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
  final NutrimentsDto? nutriments;

  FoodItemDto({
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
}
