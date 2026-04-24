import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

import '../../openfood_api.dart';
import '../models/food_item.dart';

@LazySingleton(as: IFoodRepository)
class FoodRepositoryImpl implements IFoodRepository {
  final OpenFoodApiService _apiService;

  FoodRepositoryImpl(this._apiService) {
    _apiService.initialize();
  }

  @override
  Future<List<FoodEntity>> searchProducts(String query) async {
    final List<FoodItem> items = await _apiService.search(query);

    return items.map((item) => item.toEntity()).toList();
  }

  @override
  Future<FoodEntity?> getProductByBarcode(String barcode) {
    // TODO: implement getProductByBarcode
    throw UnimplementedError();
  }
}
