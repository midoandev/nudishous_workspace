import 'package:injectable/injectable.dart';

import '../entities/plate_item.dart';
import '../repositories/sandbox_repository.dart';

@lazySingleton
class SaveMealUseCase {
  final SandboxRepository _repository;

  SaveMealUseCase(this._repository);

  Future<void> execute(List<PlateItem> plate) async {
    if (plate.isEmpty) throw Exception("Plate cannot be empty");
    return _repository.saveMeal(plate);
  }
}
