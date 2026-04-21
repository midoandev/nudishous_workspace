import 'package:core_logic/core_logic.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:injectable/injectable.dart';
import '../models/food_response.dart';

@lazySingleton
class OpenFoodApiService {
  /// Inisialisasi dikirim dari main app/shell agar fleksibel
  void initialize() {
    final currentFlavor = FlavorConfig.instance;

    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: currentFlavor.appTitle ?? '',
      url: currentFlavor.apiBaseUrl,
    );

    OpenFoodAPIConfiguration.globalUser = User(
      userId: currentFlavor.offUser ?? '',
      password: currentFlavor.offPassword ?? '',
    );
  }

  Future<List<OpenFoodItem>> search(String query) async {
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

    final result = await OpenFoodAPIClient.searchProducts(null, configuration);

    if (result.products == null) return [];

    return result.products!.map((product) {
      final nut = product.nutriments;
      return OpenFoodItem(
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
