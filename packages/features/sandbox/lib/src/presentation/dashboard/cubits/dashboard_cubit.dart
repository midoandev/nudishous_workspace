import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/entities/activity_filter.dart';

import '../../../domain/entities/daily_nutrition_entity.dart';
import '../../../domain/entities/day_nutrition_summary.dart';
import '../../../domain/usecase/get_activity_nutrition_use_case.dart';
import '../../../domain/usecase/get_daily_nutrition_usecase.dart';
import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDailyNutritionUseCase _dailyUseCase;
  final GetActivityNutritionUseCase _activityUseCase;

  DashboardCubit(this._dailyUseCase, this._activityUseCase)
    : super(DashboardInitial()) {
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    emit(DashboardLoading());
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);
    const defaultFilter = ActivityFilter.last7Days;

    final results = await Future.wait([
      _dailyUseCase(GetDailyNutritionParams(date: date)),
      _activityUseCase.call(defaultFilter),
    ]);

    final dailyResult = results[0] as Either<Failure, DailyNutritionEntity>;
    final weeklyResult =
        results[1] as Either<Failure, List<DayNutritionSummary>>;

    // Jika salah satu gagal
    final failure =
        dailyResult.fold((f) => f, (_) => null) ??
        weeklyResult.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(DashboardError(failure.message));
      return;
    }

    emit(
      DashboardLoaded(
        daily: dailyResult.getOrElse(() => throw Error()),
        weekly: weeklyResult.getOrElse(() => throw Error()),
        selectedDate: now,
        activityFilter: defaultFilter,
      ),
    );
  }

  // Fetch khusus Daily (Saat ganti tanggal di Header)
  Future<void> updateDate(DateTime date) async {
    final currentState = state;
    if (currentState is! DashboardLoaded) return;

    // Optional: Tampilkan loading kecil/overlay di UI jika perlu
    final result = await _dailyUseCase(GetDailyNutritionParams(date: date));

    result.fold(
          (f) => emit(DashboardError(f.message)),
          (data) => emit(currentState.copyWith(
        daily: data,
        selectedDate: date,
      )),
    );
  }

  // Fetch khusus Activity (Saat ganti filter Chart)
  Future<void> updateActivityFilter(ActivityFilter filter) async {
    final currentState = state;
    if (currentState is! DashboardLoaded) return;

    final result = await _activityUseCase.call(filter);

    result.fold(
          (f) => emit(DashboardError(f.message)),
          (data) => emit(currentState.copyWith(
        weekly: data,
        activityFilter: filter,
      )),
    );
  }
}
