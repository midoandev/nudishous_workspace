
class NutrimentsDto{
  double? energyKcal100G;
  double? energyKj100G;
  double? proteins100G;
  double? fat100G;
  double? saturatedFat100G;
  double? carbohydrates100G;
  double? sugars100G;
  double? calcium100G;
  double? cholesterol100G;
  double? sodium100G;
  double? salt100G;
  double? fiber100G;

  NutrimentsDto({
  this.energyKcal100G,
  this.energyKj100G,
  this.proteins100G,
  this.fat100G,
  this.saturatedFat100G,
  this.carbohydrates100G,
  this.sugars100G,
  this.calcium100G,
  this.cholesterol100G,
  this.sodium100G,
  this.salt100G,
  this.fiber100G,
  });

  Map<String, dynamic> toJson() => {
  "energy-kcal_100g": energyKcal100G,
  "energy-kj_100g": energyKj100G,
  "proteins_100g": proteins100G,
  "fat_100g": fat100G,
  "saturated-fat_100g": saturatedFat100G,
  "carbohydrates_100g": carbohydrates100G,
  "sugars_100g": sugars100G,
  "calcium_100g": calcium100G,
  "cholesterol_100g": cholesterol100G,
  "sodium_100g": sodium100G,
  "salt_100g": salt100G,
  "fiber_100g": fiber100G,
  };
  }
