import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/entities/meal_session_entity.dart';
import '../../../domain/usecase/get_daily_nutrition_usecase.dart';
import '../cubits/meals_state.dart';

@injectable
class MealsCubit extends Cubit<MealsState> {
  final GetDailyNutritionUseCase _dailyUseCase;

  MealsCubit(this._dailyUseCase) : super(MealsInitial()) {
    fetchMealsData();
  }

  Future<void> fetchMealsData() async {
    emit(MealsLoading());
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    final results = await _dailyUseCase(GetDailyNutritionParams(date: date));
    results.fold((l) => emit(MealsError((l.message))), (nutrition) {
      // 1. Gunakan Map sementara untuk grouping (Bukan List)
      final Map<DateTime, List<MealSessionEntity>> tempMap = {};

      for (var session in nutrition.recentSessions) {
        // Normalisasi tanggal agar jam/menit tidak mengganggu grouping
        final dateKey = DateTime(
          session.eatenAt.year,
          session.eatenAt.month,
          session.eatenAt.day,
        );

        // putIfAbsent sekarang dipanggil pada Map (tempMap)
        tempMap.putIfAbsent(dateKey, () => []).add(session);
      }

      // 2. Konversi Map ke List of Entries dan SORT Descending (Terbaru di atas)
      final List<MapEntry<DateTime, List<MealSessionEntity>>> sortedGroups =
          tempMap.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

      // 3. Emit state dengan data yang sudah bersih dan urut
      emit(MealsLoaded(groups: sortedGroups, selectedDate: date));
    });
  }

  // Future<void> updateDate(DateTime date) async {
  //   final currentState = state;
  //   if (currentState is! MealsLoaded) return;
  //
  //   // Optional: Tampilkan loading kecil/overlay di UI jika perlu
  //   final result = await _dailyUseCase(GetDailyNutritionParams(date: date));
  //
  //   result.fold(
  //     (f) => emit(MealsError(f.message)),
  //     (data) => emit(currentState.copyWith(daily: data, selectedDate: date)),
  //   );
  // }
}
