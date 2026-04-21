import 'package:core_logic/core_logic.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

class DashboardUpdated extends BaseState {
  final List<MealEntry> item;

  const DashboardUpdated(this.item);

  double get totalCalories =>
      item.fold(0, (sum, item) => sum + item.calculatedCalories);

  double get totalProtein =>
      item.fold(0, (sum, item) => sum + item.calculatedProtein);

  @override
  List<Object?> get props => [item];
}
