import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/repositories/sandbox_repository.dart';

import '../entities/food_entity.dart';

@injectable
class SearchFoodUseCase {
  final SandboxRepository _repository;

  SearchFoodUseCase(this._repository);

  Future<List<FoodEntity>> execute(String query) {
    if (query.isEmpty) return Future.value([]);
    return _repository.searchProducts(query);
  }
}