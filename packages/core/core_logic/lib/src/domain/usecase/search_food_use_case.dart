import 'package:injectable/injectable.dart';

import '../../../core_logic.dart';

@injectable
class SearchFoodUseCase {
  final IFoodRepository _repository;

  SearchFoodUseCase(this._repository);

  Future<List<FoodEntity>> execute(String query) {
    if (query.isEmpty) return Future.value([]);
    return _repository.searchProducts(query);
  }
}