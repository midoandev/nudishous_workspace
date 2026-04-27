import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/presentation/add_meal/cubits/add_meal_state.dart';

import '../../../domain/entities/food_entity.dart';
import '../../../domain/entities/meal_type.dart';
import '../../../domain/entities/plate_item.dart';
import '../../../domain/usecase/add_meal_use_case.dart';

@injectable
class AddMealCubit extends Cubit<AddMealState> {
  final AddMealUseCase _addMealUseCase; // Panggil UseCase, jangan Repository langsung

  AddMealCubit(this._addMealUseCase)
      : super(AddMealState(selectedMealType: _guessMealType()));

  // 1. Tambah Makanan ke Piring (Data dari SearchPage)
  void addToPlate(FoodEntity food) {
    // Cek dulu apakah makanan sudah ada di piring, biar nggak duplikat ID-nya
    final isExist = state.plateItems.any((item) => item.food.code == food.code);
    if (isExist) return;

    final newItem = PlateItem(
      id: DateTime.now().toString(), // ID unik untuk list di piring
      food: food,
      weightGrams: 100, // Default 100g
    );

    final updatedPlate = [...state.plateItems, newItem];
    emit(
      state.copyWith(
        plateItems: updatedPlate,
        totalCalories: _calculateTotal(updatedPlate),
      ),
    );
  }

  // 2. Update Berat Makanan
  void updateWeight(PlateItem item, double weight) {
    final updatedList = state.plateItems.map((e) {
      // Bandingkan pakai code unik dari FoodEntity
      return e.food.code == item.food.code
          ? e.copyWith(weightGrams: weight)
          : e;
    }).toList();

    emit(
      state.copyWith(
        plateItems: updatedList,
        totalCalories: _calculateTotal(updatedList),
      ),
    );
  }

  // 3. Hapus dari Piring
  void removeFromPlate(PlateItem item) {
    final updatedPlate = state.plateItems
        .where((e) => e.food.code != item.food.code)
        .toList();

    emit(
      state.copyWith(
        plateItems: updatedPlate,
        totalCalories: _calculateTotal(updatedPlate),
      ),
    );
  }

  // 4. Hitung Total Kalori (LaTeX Logic)
  // Total = sum( (weight / 100) * calories100g )
  double _calculateTotal(List<PlateItem> items) {
    return items.fold(0, (sum, item) {
      return sum + ((item.weightGrams / 100) * item.food.calories100g);
    });
  }

  // Logic menebak waktu makan
  static MealType _guessMealType() {
    final hour = DateTime
        .now()
        .hour;
    if (hour >= 4 && hour < 11) return MealType.breakfast;
    if (hour >= 11 && hour < 16) return MealType.lunch;
    if (hour >= 16 && hour < 21) return MealType.dinner;
    return MealType.snack;
  }

  void changeMealType(MealType type) {
    emit(state.copyWith(selectedMealType: type));
  }

  // 5. Simpan Semua ke Database
  Future<void> saveAllMeals() async {
    if (state.plateItems.isEmpty) return;
    emit(state.copyWith(status: AddMealStatus.saving));

    final date = DateTime.now();
    final result = await _addMealUseCase.call(
      AddMealParams(
        items: state.plateItems, // ← semua item sekaligus
        mealType: state.selectedMealType,
        eatenAt: date.copyWith(day: date.day),
      ),
    );

    result.fold(
          (failure) =>
          emit(state.copyWith(
            status: AddMealStatus.failure,
            errorMessage: failure.message,
          )),
          (_) =>
          emit(state.copyWith(
            status: AddMealStatus.success,
            plateItems: [],
          )),
    );
  }
}