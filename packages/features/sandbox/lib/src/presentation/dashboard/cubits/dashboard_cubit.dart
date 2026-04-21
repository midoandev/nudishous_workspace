import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

import 'dashboard_state.dart';

@singleton
class DashboardCubit extends Cubit<DashboardUpdated> {
  DashboardCubit() : super(const DashboardUpdated([]));

  void addItem(MealEntry item) {
    final newList = List<MealEntry>.from(state.item)..add(item);
    emit(DashboardUpdated(newList));
  }

  void updateQuantity(String id, double grams) {
    final newList = state.item.map((item) {
      return item.id == id ? item.copyWith(grams: grams) : item;
    }).toList();
    emit(DashboardUpdated(newList));
  }
}
