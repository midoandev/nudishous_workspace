import '../../../core_logic.dart';

abstract class IFoodRepository {
  Future<List<FoodEntity>> searchProducts(String query);
  Future<FoodEntity?> getProductByBarcode(String barcode);
}