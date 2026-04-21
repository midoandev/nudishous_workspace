import 'package:core_logic/core_logic.dart';
import 'package:openfood_api/openfood_api.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

import '../../../domain/entities/plate_item.dart';

class AddMealState extends BaseState {
  final List<MealEntry> searchResults;
  final List<PlateItem> plateItems;
  final String? errorMessage;
  final bool isLoading;

  const AddMealState({
    this.searchResults = const [],
    this.plateItems = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  // Manual copyWith
  AddMealState copyWith({
    List<MealEntry>? searchResults,
    List<PlateItem>? plateItems,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AddMealState(
      searchResults: searchResults ?? this.searchResults,
      plateItems: plateItems ?? this.plateItems,
      errorMessage: errorMessage, // Kita biarkan null jika tidak di-pass
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Kalkulasi total di level state
  double get totalCalories =>
      plateItems.fold(0, (sum, item) => sum + item.calories);

  @override
  List<Object?> get props => [
    searchResults,
    plateItems,
    errorMessage,
    isLoading,
  ];
}
