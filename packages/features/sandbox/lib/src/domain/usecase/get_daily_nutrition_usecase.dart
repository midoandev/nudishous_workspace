// sandbox/domain/usecases/get_daily_nutrition_usecase.dart
import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox/src/domain/repositories/sandbox_repository.dart';
import '../entities/daily_nutrition_entity.dart';

class GetDailyNutritionParams extends Equatable {
  final DateTime date;
  final int recentLimit; // default 10

  const GetDailyNutritionParams({required this.date, this.recentLimit = 10});

  @override
  List<Object?> get props => [date, recentLimit];
}

@lazySingleton
class GetDailyNutritionUseCase
    extends UseCase<DailyNutritionEntity, GetDailyNutritionParams> {
  final SandboxRepository _repository;

  GetDailyNutritionUseCase(this._repository);

  @override
  Future<Either<Failure, DailyNutritionEntity>> call(
    GetDailyNutritionParams params,
  ) async {
    // Ambil semua sesi di tanggal ini
    final result = await _repository.getSessionsByDate(params.date);

    return result.fold((failure) => Left(failure), (sessions) {
      // ✅ Kalkulasi dilakukan di usecase, bukan di UI/cubit
      double totalCalories = 0;
      double totalProtein = 0;
      double totalCarbs = 0;
      double totalFat = 0;

      for (final session in sessions) {
        for (final item in session.items) {
          final ratio = item.weightGram / 100;
          totalCalories += ratio * item.food.calories100g;
          totalProtein += ratio * item.food.proteins100g;
          totalCarbs += ratio * item.food.carbs100g;
          totalFat += ratio * item.food.fats100g;
        }
      }

      // Ambil hanya N sesi terbaru untuk home
      final recentSessions = sessions.length > params.recentLimit
          ? sessions.sublist(0, params.recentLimit)
          : sessions;

      return Right(
        DailyNutritionEntity(
          totalCalories: totalCalories,
          totalProtein: totalProtein,
          totalCarbs: totalCarbs,
          totalFat: totalFat,
          calorieGoal: 2000,
          // TODO: ambil dari user settings
          recentSessions: recentSessions,
          totalSessionCount: sessions.length,
        ),
      );
    });
  }
}
