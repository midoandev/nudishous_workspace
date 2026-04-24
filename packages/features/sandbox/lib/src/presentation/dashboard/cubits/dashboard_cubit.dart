import 'package:core_logic/core_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'dashboard_state.dart';


@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDailyNutritionUseCase _getDailyNutrition;

  DashboardCubit(this._getDailyNutrition) : super(DashboardLoading()){
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    emit(DashboardLoading());
    try {
      final nutrition = await _getDailyNutrition.execute(DateTime.now());

      emit(DashboardLoaded(
        nutrition: nutrition,
        dailyGoal: 2000, // Sementara hardcoded, nanti ambil dari Prefs
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}