
import 'package:injectable/injectable.dart';

import '../../../core_logic.dart';

@injectable
class AddMealUseCase {
  final IMealRepository _repository;

  AddMealUseCase(this._repository);

  Future<void> execute({
    required FoodEntity food,
    required double weight,
    DateTime? consumedAt,
  }) async {
    // Logic: Repository akan handle pengecekan 'exist or insert' untuk FoodEntity
    await _repository.saveMeal(
      food: food,
      weight: weight,
      date: consumedAt ?? DateTime.now(),
    );
  }
}