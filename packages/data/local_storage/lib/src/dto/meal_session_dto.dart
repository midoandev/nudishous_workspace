import '../../local_storage.dart';

class MealSessionDto {
  final int id;
  final DateTime eatenAt;
  final String mealType;
  final String? notes;
  final List<MealItemDto> items; // ← sudah include items!

  const MealSessionDto({
    required this.id,
    required this.eatenAt,
    required this.mealType,
    this.notes,
    required this.items,
  });
}