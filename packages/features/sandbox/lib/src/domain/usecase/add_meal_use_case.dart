import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/meal_type.dart';
import '../entities/plate_item.dart';
import '../repositories/sandbox_repository.dart';

class AddMealParams extends Equatable {
  final List<PlateItem> items;
  final MealType mealType;
  final DateTime eatenAt;

  const AddMealParams({
    required this.items,
    required this.mealType,
    required this.eatenAt,
  });

  @override
  List<Object?> get props => [items, mealType, eatenAt];
}

@lazySingleton
class AddMealUseCase extends UseCase<void, AddMealParams> {
  final SandboxRepository _repository;
  AddMealUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AddMealParams params) =>
      _repository.saveMealSession(
        items: params.items,
        mealType: params.mealType,
        eatenAt: params.eatenAt,
      );
}