// packages/core/core_logic/lib/src/domain/entities/food_entity.dart
import 'package:equatable/equatable.dart';
class FoodEntity extends Equatable {
  final String code;
  final String name;
  final String brand;
  final String imageUrl;
  final double calories100g;
  final double proteins100g;
  final double carbs100g;
  final double fats100g;

  // Field untuk Tampilan Pro
  final String servingSize;
  final double servingQuantity;
  final String nutriscore; // A, B, C, D, E
  final String ecoscore;
  final int novaGroup;

  const FoodEntity({
    required this.code,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.calories100g,
    required this.proteins100g,
    required this.carbs100g,
    required this.fats100g,
    this.servingSize = '',
    this.servingQuantity = 0,
    this.nutriscore = '?',
    this.ecoscore = '?',
    this.novaGroup = 0,
  });

  @override
  List<Object?> get props => [code, name, brand];
}