import 'package:core_logic/core_logic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@module
abstract class LocalStorageModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );
}