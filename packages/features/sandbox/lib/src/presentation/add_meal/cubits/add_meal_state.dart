import 'package:equatable/equatable.dart';

import '../../../domain/entities/meal_type.dart';
import '../../../domain/entities/plate_item.dart';

enum AddMealStatus { initial, loading, saving, success, failure }

class AddMealState extends Equatable {
  final List<PlateItem> plateItems;
  final MealType selectedMealType; // TAMBAHKAN INI
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final AddMealStatus status;
  final String? errorMessage;

  const AddMealState({
    this.plateItems = const [],
    this.totalCalories = 0,
    this.totalProtein = 0,
    this.totalCarbs = 0,
    this.totalFat = 0,
    this.status = AddMealStatus.initial,
    this.selectedMealType = MealType.snack,
    this.errorMessage,
  });

  // Memudahkan pengecekan status di UI
  bool get isSaving => status == AddMealStatus.saving;
  bool get isSuccess => status == AddMealStatus.success;

  AddMealState copyWith({
    List<PlateItem>? plateItems,
    double? totalCalories,
    double? totalProtein,
    double? totalCarbs,
    double? totalFat,
    AddMealStatus? status,
    String? errorMessage,
    MealType? selectedMealType,
  }) {
    return AddMealState(
      plateItems: plateItems ?? this.plateItems,
      totalCalories: totalCalories ?? this.totalCalories,
      totalProtein: totalProtein ?? this.totalProtein,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      status: status ?? this.status,
      selectedMealType: selectedMealType ?? this.selectedMealType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    plateItems,
    totalCalories,
    totalProtein,
    totalCarbs,
    totalFat,
    status,
    errorMessage,
  ];
}