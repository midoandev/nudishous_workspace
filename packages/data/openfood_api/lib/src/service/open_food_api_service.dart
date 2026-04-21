import 'package:core_logic/core_logic.dart';
import 'package:injectable/injectable.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../models/food_item.dart';

@lazySingleton
class OpenFoodApiService {
  /// Inisialisasi dikirim dari main app/shell agar fleksibel
  void initialize() {
    final currentFlavor = FlavorConfig.instance;

    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Nudishous',
      url: 'https://nudishous.com',
    );

    OpenFoodAPIConfiguration.globalUser = User(
      userId: currentFlavor.offUser ?? '',
      password: currentFlavor.offPassword ?? '',
    );
    print(
      'fasd ${currentFlavor.offUser} ${currentFlavor.offPassword} ${currentFlavor.apiBaseUrl} ${currentFlavor.appTitle}',
    );
  }

  Future<List<FoodItem>> search(String query) async {
    final configuration = ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        SearchTerms(terms: [query]),
      ],
      language: OpenFoodFactsLanguage.INDONESIAN,
      fields: [
        ProductField.BARCODE,
        ProductField.NAME,
        ProductField.IMAGE_FRONT_URL,
        ProductField.NUTRIMENTS,
      ],
      version: ProductQueryVersion.v3,
    );
    print('dsklfmk $query');
    final result = await OpenFoodAPIClient.searchProducts(null, configuration);
    if (result.products == null) return [];

    return result.products!.map((product) {
      final nut = product.nutriments;
      return FoodItem(
        barcode: product.barcode ?? '',
        name: product.productName ?? 'Unknown',
        imageUrl: product.imageFrontUrl,
        calories:
            nut?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0,
        carbs:
            nut?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0,
        protein: nut?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0,
        fat: nut?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0,
      );
    }).toList();
  }
}
