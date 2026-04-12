// apps/nudishous_app/lib/di/injection_container.dart
import 'package:core_logic/core_logic.dart';
import 'package:local_storage/local_storage.dart';
import 'package:nudishous/core/router/app_router.dart';
import 'package:remote_api/remote_api.dart';
import 'package:auth/auth.dart';
import 'package:profile/profile.dart';


Future<void> configureDependencies() async {
  // 1. Async manual registration
  // ✅ SharedPreferences — di-register manual di sini karena async
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);


  // 2. Generated configurators — urutan wajib!
  await configureLocalStorageInjection();
  await configureNetworkInjection();
  // await configureFirebaseInjection();
  await configureAuthInjection();
  await configureProfileInjection();
  // await configureSandboxInjection();

  // 3. Router
  getIt.registerSingleton(AppRouter());
}