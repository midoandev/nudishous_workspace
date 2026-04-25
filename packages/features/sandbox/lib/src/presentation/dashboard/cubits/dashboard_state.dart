import 'package:core_logic/core_logic.dart';

sealed class DashboardState extends BaseState {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DailyNutritionEntity nutrition;
  final List<MealGroup> mealGroups;
  final double dailyGoal;

  const DashboardLoaded({
    required this.nutrition,
    required this.mealGroups,
    required this.dailyGoal,
  });

  @override
  List<Object?> get props => [nutrition, mealGroups, dailyGoal];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
}