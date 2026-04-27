import 'package:core_logic/core_logic.dart';
import 'package:sandbox/src/domain/entities/activity_filter.dart';

import '../../../domain/entities/daily_nutrition_entity.dart';
import '../../../domain/entities/day_nutrition_summary.dart';

sealed class DashboardState extends BaseState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DailyNutritionEntity daily;
  final List<DayNutritionSummary> weekly;
  final DateTime selectedDate;
  final ActivityFilter activityFilter;

  const DashboardLoaded({
    required this.daily,
    required this.weekly,
    required this.selectedDate,
    required this.activityFilter,
  });

  @override
  List<Object?> get props => [daily, weekly, selectedDate, activityFilter];

  // Helper untuk update partial state
  DashboardLoaded copyWith({
    DailyNutritionEntity? daily,
    List<DayNutritionSummary>? weekly,
    DateTime? selectedDate,
    ActivityFilter? activityFilter,
  }) {
    return DashboardLoaded(
      daily: daily ?? this.daily,
      weekly: weekly ?? this.weekly,
      selectedDate: selectedDate ?? this.selectedDate,
      activityFilter: activityFilter ?? this.activityFilter,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);
}
