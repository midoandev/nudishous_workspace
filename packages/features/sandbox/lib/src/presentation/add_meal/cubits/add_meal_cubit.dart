import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';
import 'package:sandbox/src/presentation/add_meal/cubits/add_meal_state.dart';

import '../../../domain/entities/plate_item.dart';
import '../../../domain/repositories/sandbox_repository.dart';

@injectable
class AddMealCubit extends Cubit<AddMealState> {
  final SandboxRepository _repository;

  AddMealCubit(this._repository) : super(const AddMealState());

  // 1. Logic Pencarian (Debounce biasanya di UI atau di sini)
  Future<void> searchFood(String query) async {
    if (query.length < 3) {
      emit(state.copyWith(searchResults: []));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final results = await _repository.searchFood(query);
      emit(state.copyWith(searchResults: results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // 2. Logic Tambah ke Piring
  void addToPlate(MealEntry food) {
    final newItem = PlateItem(food: food);
    final updatedPlate = List<PlateItem>.from(state.plateItems)..add(newItem);

    emit(
      state.copyWith(
        plateItems: updatedPlate,
        searchResults: [], // Clear search setelah pilih
      ),
    );
  }

  void updateWeight(int index, double weight) {
    final newList = List<PlateItem>.from(state.plateItems);
    newList[index] = newList[index].copyWith(weightGrams: weight);
    emit(state.copyWith(plateItems: newList));
  }

  // 4. Hapus dari Piring
  void removeFromPlate(int index) {
    final updatedPlate = List<PlateItem>.from(state.plateItems)
      ..removeAt(index);
    emit(state.copyWith(plateItems: updatedPlate));
  }
}
