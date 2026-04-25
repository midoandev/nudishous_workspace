import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDailyNutritionUseCase {
  final IMealRepository _repository;

  GetDailyNutritionUseCase(this._repository);

  Future<DailyNutritionEntity> execute(DateTime date) async {
    final logDatas = await _repository.getLogsByDate(date);

    double calories = 0;
    double protein = 0;
    double carbs = 0;
    double fat = 0;

    for (var log in logDatas) {
      // Perhitungan berdasarkan berat makanan yang dikonsumsi (gram)
      // Rumus: (berat_input / 100) * nilai_nutrisi_per_100g
      final ratio = log.weightGram / 100;

      calories += ratio * log.food.calories100g;
      protein += ratio * log.food.proteins100g;
      carbs += ratio * log.food.carbs100g;
      fat += ratio * log.food.fats100g;
    }

    return DailyNutritionEntity(
      logs: logDatas,
      totalCalories: calories,
      totalProtein: protein,
      totalCarbs: carbs,
      totalFat: fat,
    );
  }
}