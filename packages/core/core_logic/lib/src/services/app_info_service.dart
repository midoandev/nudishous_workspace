import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String version;
  final String buildNumber;

  AppInfo({required this.version, required this.buildNumber});

  // Static instance untuk akses global yang instan (setelah di-init)
  static late AppInfo instance;

  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    instance = AppInfo(
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }

  // Getter gabungan yang rapi
  static String get fullVersion {
    const suffix = kDebugMode ? ' (DEBUG)' : '';
    return '${instance.version}$suffix';
    }
}