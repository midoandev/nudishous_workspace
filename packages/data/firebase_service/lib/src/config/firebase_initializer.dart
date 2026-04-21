import 'package:core_logic/core_logic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_service/src/config/firebase_options/firebase_options_dev.dart'
    as dev;
import 'package:firebase_service/src/config/firebase_options/firebase_options_prod.dart'
    as prod;

class FirebaseInitializer {
  static Future<void> initialize() async {
    final currentFlavor = FlavorConfig.instance.flavor;

    final options = currentFlavor == Flavor.dev
        ? dev.DefaultFirebaseOptions.currentPlatform
        : prod.DefaultFirebaseOptions.currentPlatform;

    print('🚀 [FIREBASE VERIFICATION]');
    print('🔥 Project ID: ${options.projectId}');
    print('🔥 App ID: ${options.appId}'); // Pastikan ID .dev atau prod sesuai
    print('🔥 Storage Bucket: ${options.storageBucket}');
    print('---------------------------');
    await Firebase.initializeApp(options: options);
  }
}
