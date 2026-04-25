import 'package:core_logic/core_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDailyNutritionUseCase _getDailyNutrition;

  DashboardCubit(this._getDailyNutrition) : super(DashboardLoading()) {
    fetchDashboardData(date: DateTime.now());
  }

  Future<void> fetchDashboardData({DateTime? date}) async {
    emit(DashboardLoading());
    try {
      final nutrition = await _getDailyNutrition.execute(
        date ?? DateTime.now(),
      );

      // LOGIC GROUPING DI SINI
      final groupedMap = <MealType, List<MealLogEntity>>{};
      for (var log in nutrition.logs) {
        groupedMap.putIfAbsent(log.mealType, () => []).add(log);
      }

      final mealGroups = groupedMap.entries
          .map(
            (e) => MealGroup(
              mealType: e.key,
              items: e.value,
              timestamp: e.value.first.eatenAt,
            ),
          )
          .toList();
      mealGroups.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      emit(
        DashboardLoaded(
          nutrition: nutrition,
          mealGroups: mealGroups,
          dailyGoal: 2100, // Ambil dari preference nanti
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
