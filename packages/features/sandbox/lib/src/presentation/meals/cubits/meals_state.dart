import 'package:core_logic/core_logic.dart';
import 'package:sandbox/src/domain/entities/meal_session_entity.dart';


sealed class MealsState extends BaseState {
  const MealsState();
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MapEntry<DateTime, List<MealSessionEntity>>> groups;
  final DateTime selectedDate;

  const MealsLoaded({required this.groups, required this.selectedDate});

  @override
  List<Object?> get props => [groups, selectedDate];

  // Helper untuk update partial state
  MealsLoaded copyWith({
    List<MapEntry<DateTime, List<MealSessionEntity>>>? groups,
    DateTime? selectedDate,
  }) {
    return MealsLoaded(
      groups: groups ?? this.groups,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class MealsError extends MealsState {
  final String error;

  const MealsError(this.error);
}
