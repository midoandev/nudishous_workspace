import 'package:injectable/injectable.dart';

import '../../domain/repositories/sandbox_repository.dart';

@LazySingleton(as: SandboxRepository)
class SandboxRepositoryImpl implements SandboxRepository {
//   final OpenFoodApiService _apiService;
//
//   SandboxRepositoryImpl(this._apiService) {
//     _apiService.initialize();
//   }
//
//   @override
//   Future<List<MealEntry>> searchFood(String query) async {
//     final dtoList = await _apiService.search(query);
//     debugPrint('dsfdskfm ${dtoList.length}');
//     // Mapping dari DTO Package ke Entity Domain kita
//     return dtoList
//         .map(
//           (dto) => MealEntry(
//             id: dto.barcode,
//             name: dto.name,
//             imageUrl: dto.imageUrl ?? '',
//             calories: dto.calories,
//             protein: dto.protein,
//             carbs: dto.carbs,
//             fat: dto.fat,
//           ),
//         )
//         .toList();
//   }
//
//   @override
//   Future<void> saveMeal(List<PlateItem> item) {
//     // TODO: implement saveMeal
//     throw UnimplementedError();
//   }
}
