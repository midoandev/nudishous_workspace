import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/activity_filter.dart';
import '../entities/day_nutrition_summary.dart';
import '../repositories/sandbox_repository.dart';

@lazySingleton
class GetActivityNutritionUseCase {
  final SandboxRepository _repository;

  GetActivityNutritionUseCase(this._repository);

  Future<Either<Failure, List<DayNutritionSummary>>> call(ActivityFilter filter) async {
    final now = DateTime.now();
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // 1. Tentukan Start Date berdasarkan filter
    final startDate = switch (filter) {
      ActivityFilter.last7Days => endDate.subtract(const Duration(days: 6)),
      ActivityFilter.last30Days => endDate.subtract(const Duration(days: 29)),
      ActivityFilter.currentMonth => DateTime(now.year, now.month, 1),
    };

    // 2. Fetch data sekaligus dalam satu range
    final result = await _repository.getSessionsByDate(
      DateTime(startDate.year, startDate.month, startDate.day),
      endDate: endDate,
    );

    return result.map((allSessions) {
      final Map<DateTime, DayNutritionSummary> dailyMap = {};

      // 3. Grouping & Aggregating data dari sessions
      for (final session in allSessions) {
        final dateKey = DateTime(session.eatenAt.year, session.eatenAt.month, session.eatenAt.day);

        double cal = 0, pro = 0, cho = 0, fat = 0;
        for (final item in session.items) {
          final ratio = item.weightGram / 100;
          cal += ratio * item.food.calories100g;
          pro += ratio * item.food.proteins100g;
          cho += ratio * item.food.carbs100g;
          fat += ratio * item.food.fats100g;
        }

        dailyMap.update(
          dateKey,
              (existing) => DayNutritionSummary(
            date: dateKey,
            totalCalories: existing.totalCalories + cal,
            totalProtein: existing.totalProtein + pro,
            totalCarbs: existing.totalCarbs + cho,
            totalFat: existing.totalFat + fat,
          ),
          ifAbsent: () => DayNutritionSummary(
            date: dateKey,
            totalCalories: cal,
            totalProtein: pro,
            totalCarbs: cho,
            totalFat: fat,
          ),
        );
      }

      // 4. Fill gaps (Pastikan hari tanpa data tetap muncul sebagai 0 di grafik)
      final List<DayNutritionSummary> finalResults = [];
      final daysCount = endDate.difference(startDate).inDays;

      for (int i = 0; i <= daysCount; i++) {
        final currentDay = DateTime(startDate.year, startDate.month, startDate.day).add(Duration(days: i));
        finalResults.add(
          dailyMap[currentDay] ?? DayNutritionSummary(
            date: currentDay,
            totalCalories: 0,
            totalProtein: 0,
            totalCarbs: 0,
            totalFat: 0,
          ),
        );
      }

      return finalResults;
    });
  }
}