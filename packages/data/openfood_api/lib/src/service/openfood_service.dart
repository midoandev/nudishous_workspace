import 'dart:async';

import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:openfood_api/openfood_api.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

@lazySingleton
class OpenfoodService {

  OpenfoodService() {
    _initialize();
  }

  /// Inisialisasi dikirim dari main app/shell agar fleksibel
  void _initialize() {
    final currentFlavor = FlavorConfig.instance;

    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'NudishousApp',
      version: '1.0.0',
      url: 'https://nudishous.com',
      system: 'Android/iOS',
    );

    // 2. Set Bahasa dan Negara Global (KRUSIAL)
    // OpenFoodAPIConfiguration.globalLanguages = [
    //   OpenFoodFactsLanguage.INDONESIAN,
    // ];
    // OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.INDONESIA;

    OpenFoodAPIConfiguration.globalUser = User(
      userId: currentFlavor.offUser ?? '',
      password: currentFlavor.offPassword ?? '',
    );

    debugPrint(
      'fasd ${currentFlavor.offUser} ${currentFlavor
          .offPassword} ${currentFlavor.apiBaseUrl} ${currentFlavor.appTitle}',
    );
  }

  Future<List<FoodItemDto>> search(String query) async {
    // Validasi input minimal 3 karakter untuk efisiensi API
    if (query.isEmpty || query.length < 3) return [];

    try {
      final configuration = ProductSearchQueryConfiguration(
        parametersList: <Parameter>[
          SearchTerms(terms: [query]),
          const PageSize(size: 10),
          const SortBy(option: SortOption.POPULARITY),
          const StatesTagsParameter(
            map: {
              ProductState.NUTRITION_FACTS_COMPLETED: true,
              // ProductState.CHECKED: true,
              // ProductState.COMPLETED: true,
            },
          ),
        ],
        // language: OpenFoodFactsLanguage.INDONESIAN,
        fields: [
          ProductField.NAME,
          ProductField.BRANDS,
          ProductField.BARCODE,
          ProductField.IMAGE_FRONT_URL,
          ProductField.NUTRIMENTS,
          ProductField.QUANTITY,
          ProductField.NUTRIMENTS,
          ProductField.SERVING_SIZE,
          ProductField.NUTRISCORE,
          ProductField.NOVA_GROUP,
          ProductField.ALLERGENS,
          ProductField.INGREDIENTS_TEXT,
          ProductField.CATEGORIES,
          ProductField.IMAGE_NUTRITION_URL,
        ],
        version: ProductQueryVersion.v3,
      );

      // Tambahkan timeout agar aplikasi tidak "gantung" saat koneksi lambat
      final result = await OpenFoodAPIClient.searchProducts(
        null,
        configuration,
      );

      // Log status untuk debugging M.Kom style
      debugPrint(
        '🔍 Search Result Status: ${result.pageSize} ${result.page} ${result
            .count} ${result.pageCount}',
      );

      if (result.products == null) return [];

      return result.products!.map((product) {
        // Tetap debugPrint untuk memantau data mentah jika perlu
        debugPrint(
          '🔍 Mapping Product: ${product.barcode} - ${product.productName}',
        );

        final nut = product.nutriments;

        return FoodItemDto(
          code: product.barcode,
          productName: product.productName,
          brands: product.brands,
          quantity: product.quantity,
          imageFrontUrl: product.imageFrontUrl,
          imageFrontSmallUrl: product.imageFrontSmallUrl,
          // Penting untuk optimasi list
          servingSize: product.servingSize,
          servingQuantity: product.servingQuantity,
          nutriscore: product.nutriscore,
          ecoscore: product.ecoscoreGrade,
          novaGroup: product.novaGroup,

          // Mapping ke nested class Nutriments milik kita
          nutriments: NutrimentsDto(
            energyKcal100G: nut?.getValue(
              Nutrient.energyKCal,
              PerSize.oneHundredGrams,
            ),
            energyKj100G: nut?.getValue(
              Nutrient.energyKJ,
              PerSize.oneHundredGrams,
            ),
            proteins100G: nut?.getValue(
              Nutrient.proteins,
              PerSize.oneHundredGrams,
            ),
            fat100G: nut?.getValue(Nutrient.fat, PerSize.oneHundredGrams),
            saturatedFat100G: nut?.getValue(
              Nutrient.saturatedFat,
              PerSize.oneHundredGrams,
            ),
            carbohydrates100G: nut?.getValue(
              Nutrient.carbohydrates,
              PerSize.oneHundredGrams,
            ),
            sugars100G: nut?.getValue(Nutrient.sugars, PerSize.oneHundredGrams),
            calcium100G: nut?.getValue(
              Nutrient.calcium,
              PerSize.oneHundredGrams,
            ),
            cholesterol100G: nut?.getValue(
              Nutrient.cholesterol,
              PerSize.oneHundredGrams,
            ),
            sodium100G: nut?.getValue(Nutrient.sodium, PerSize.oneHundredGrams),
            salt100G: nut?.getValue(Nutrient.salt, PerSize.oneHundredGrams),
            fiber100G: nut?.getValue(Nutrient.fiber, PerSize.oneHundredGrams),
          ),
        );
      }).toList();
    } on TimeoutException {
      throw Exception('Connection Timeout'); // Lempar ke Cubit
    } catch (e) {
      throw Exception('API_ERROR: $e'); // Lempar ke Cubit
    }
  }
}
