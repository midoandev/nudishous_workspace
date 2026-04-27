import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';
import 'package:openfood_api/openfood_api.dart';
import 'package:sandbox/src/domain/entities/food_entity.dart';
import 'package:sandbox/src/domain/entities/meal_type.dart';

import '../../domain/entities/meal_item_entity.dart';
import '../../domain/entities/meal_session_entity.dart';
import '../../domain/entities/plate_item.dart';
import '../../domain/repositories/sandbox_repository.dart';

@LazySingleton(as: SandboxRepository)
class SandboxRepositoryImpl implements SandboxRepository {
  final OpenfoodService _openfood;
  final DbService _localDatabase;

  SandboxRepositoryImpl(this._openfood, this._localDatabase);

  @override
  Future<List<FoodEntity>> searchProducts(String query) async {
    final dtoList = await _openfood.search(query);
    debugPrint('dsfdskfm ${dtoList.length}');
    // Mapping dari DTO Package ke Entity Domain kita
    return dtoList
        .map(
          (dto) => FoodEntity(
            code:
                dto.code ?? "no-code-${DateTime.now().millisecondsSinceEpoch}",
            name: dto.productName ?? 'Unknown Product',
            brand: dto.brands ?? 'Generic Brand',
            imageUrl: dto.imageFrontSmallUrl ?? dto.imageFrontUrl ?? '',

            // Pastikan tetap double untuk presisi kalkulasi di Add Meal
            calories100g: _calculateCalories(dto.nutriments),
            proteins100g: dto.nutriments?.proteins100G ?? 0.0,
            carbs100g: dto.nutriments?.carbohydrates100G ?? 0.0,
            fats100g: dto.nutriments?.fat100G ?? 0.0,

            servingSize: dto.servingSize ?? '',
            servingQuantity: dto.servingQuantity ?? 0.0,
            nutriscore: dto.nutriscore?.toUpperCase() ?? '?',
            ecoscore: dto.ecoscore?.toUpperCase() ?? '?',
            novaGroup: dto.novaGroup ?? 0,
          ),
        )
        .toList();
  }

  double _calculateCalories(NutrimentsDto? nutriments) {
    if (nutriments == null) return 0.0;

    // 1. Coba kcal dulu
    if (nutriments.energyKcal100G != null && nutriments.energyKcal100G! > 0) {
      return nutriments.energyKcal100G!;
    }

    // 2. Fallback ke kJ (1 kJ = 0.239 kcal)
    if (nutriments.energyKj100G != null && nutriments.energyKj100G! > 0) {
      return nutriments.energyKj100G! * 0.239;
    }

    return 0.0;
  }

  @override
  Future<Either<Failure, List<MealSessionEntity>>> getSessionsByDate(
    DateTime start, {
    DateTime? endDate,
  }) async {
    try {
      final dtos = await _localDatabase.getSessionsByDate(
        start: start,
        endDate: endDate,
      );

      final entities = dtos
          .map(
            (dto) => MealSessionEntity(
              id: dto.id,
              eatenAt: dto.eatenAt,
              mealType: MealType.values.firstWhere(
                (e) => e.name == dto.mealType,
                orElse: () => MealType.snack,
              ),
              notes: dto.notes,
              items: dto.items
                  .map(
                    (item) => MealItemEntity(
                      id: item.id,
                      weightGram: item.weightGram,
                      food: FoodEntity(
                        code: item.foodCode,
                        name: item.foodName,
                        brand: item.foodBrand ?? '',
                        calories100g: item.calories100g,
                        proteins100g: item.proteins100g,
                        carbs100g: item.carbs100g,
                        fats100g: item.fats100g,
                        imageUrl: item.imageUrl ?? '',
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList();

      return Right(entities);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveMealSession({
    required List<PlateItem> items,
    required MealType mealType,
    required DateTime eatenAt,
  }) async {
    try {
      // 1. Buat sesi dulu
      final sessionId = await _localDatabase.createSession(
        eatenAt: eatenAt,
        mealType: mealType.name,
      );

      // 2. Tambah semua item ke sesi
      await Future.wait(
        items.map(
          (item) => _localDatabase.addItemToSession(
            sessionId: sessionId,
            food: FoodDto(
              code: item.food.code,
              name: item.food.name,
              brand: item.food.brand,
              calories100g: item.food.calories100g,
              proteins100g: item.food.proteins100g,
              carbs100g: item.food.carbs100g,
              fats100g: item.food.fats100g,
              imageUrl: item.food.imageUrl,
            ),
            weightGram: item.weightGrams,
          ),
        ),
      );

      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(int sessionId) async {
    try {
      await _localDatabase.deleteSession(sessionId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
