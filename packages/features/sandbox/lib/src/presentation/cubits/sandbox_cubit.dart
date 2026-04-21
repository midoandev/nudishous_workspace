import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

import 'sandbox_state.dart';

@singleton
class SandboxCubit extends Cubit<SandboxUpdated> {
  SandboxCubit() : super(const SandboxUpdated([]));

  void addItem(MealEntry item) {
    final newList = List<MealEntry>.from(state.item)..add(item);
    emit(SandboxUpdated(newList));
  }

  void updateQuantity(String id, double grams) {
    final newList = state.item.map((item) {
      return item.id == id ? item.copyWith(grams: grams) : item;
    }).toList();
    emit(SandboxUpdated(newList));
  }
}
