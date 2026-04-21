`FlavorConfig` kamu sudah bagus! Sekarang mari setup FlutterFire CLI untuk project ini.

---

## Soal Versi Firebase Library

```yaml
# ✅ Benar — lock di firebase_service package sendiri
# Tidak perlu any karena hanya dipakai di sini

# packages/data/firebase_service/pubspec.yaml
dependencies:
  firebase_core: ^4.7.0
  firebase_auth: ^6.4.0
  firebase_analytics: ^12.3.0
  google_sign_in: ^7.2.0
```

Tidak perlu `any` + override di root karena Firebase library **hanya ada di `firebase_service` package** — tidak dipakai package lain.

---

## FlutterFire CLI — Step by Step

### Step 1 — Install FlutterFire CLI
```bash
# Install FlutterFire CLI global
dart pub global activate flutterfire_cli

# Pastikan firebase CLI juga terinstall
npm install -g firebase-tools

# Login ke Firebase
firebase login
```

### Step 2 — Masuk ke app shell dulu
```bash
# Wajib dijalankan dari dalam app shell
# bukan dari root workspace!
cd apps/nudishous_app
```

### Step 3 — Init Firebase untuk flavor DEV
```bash
flutterfire configure \
  --project=nudishous-dev \
  --out=lib/firebase_options_dev.dart \
  --platforms=android,ios \
  --android-app-id=id.midosaurus.nudishous.dev \
  --ios-bundle-id=id.midosaurus.nudishous.dev
```

### Step 4 — Init Firebase untuk flavor PROD
```bash
flutterfire configure \
  --project=nudishous-prod \
  --out=lib/firebase_options_prod.dart \
  --platforms=android,ios \
  --android-app-id=id.midosaurus.nudishous \
  --ios-bundle-id=id.midosaurus.nudishous
```

### Step 5 — Pindahkan generated options ke `firebase_service` package
```bash
# Pindahkan dari app shell ke firebase_service
mv apps/nudishous_app/lib/firebase_options_dev.dart \
   packages/data/firebase_service/lib/src/config/firebase_options/firebase_options_dev.dart

mv apps/nudishous_app/lib/firebase_options_prod.dart \
   packages/data/firebase_service/lib/src/config/firebase_options/firebase_options_prod.dart
```

---

## Update `FlavorConfig` — Tambah Firebase Options

```dart
// packages/data/firebase_service/lib/src/config/flavor_config.dart
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options/firebase_options_dev.dart' as dev;
import '../firebase_options/firebase_options_prod.dart' as prod;

enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  final String appTitle;
  final FirebaseOptions firebaseOptions; // ← tambahkan

  static FlavorConfig? _instance;

  FlavorConfig._internal({
    required this.flavor,
    required this.apiBaseUrl,
    required this.appTitle,
    required this.firebaseOptions,
  });

  static const _baseUrl = 'id.midosaurus.nudishous';
  static const _appName = 'Nudishous';

  static void set(Flavor flavor) {
    _instance = switch (flavor) {
      Flavor.dev => FlavorConfig._internal(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://dev-api.$_baseUrl',
        appTitle: '$_appName Dev',
        firebaseOptions: dev.DefaultFirebaseOptions.currentPlatform, // ✅
      ),
      Flavor.prod => FlavorConfig._internal(
        flavor: Flavor.prod,
        apiBaseUrl: 'https://api.$_baseUrl',
        appTitle: _appName,
        firebaseOptions: prod.DefaultFirebaseOptions.currentPlatform, // ✅
      ),
    };
  }

  static FlavorConfig get instance {
    assert(_instance != null, 'FlavorConfig.set() belum dipanggil!');
    return _instance!;
  }

  // Helper
  static bool get isDev => instance.flavor == Flavor.dev;
  static bool get isProd => instance.flavor == Flavor.prod;
}
```

---

## `FirebaseInitializer` — Pakai FlavorConfig

```dart
// packages/data/firebase_service/lib/src/config/firebase_initializer.dart
import 'package:firebase_core/firebase_core.dart';
import 'flavor_config.dart';

class FirebaseInitializer {
  static Future<void> initialize(Flavor flavor) async {
    // Set flavor dulu
    FlavorConfig.set(flavor);

    // Init Firebase dengan options sesuai flavor
    await Firebase.initializeApp(
      options: FlavorConfig.instance.firebaseOptions,
    );
  }
}
```

---

## `main_dev.dart` & `main_prod.dart`

```dart
// apps/nudishous_app/lib/main_dev.dart
import 'package:firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize(Flavor.dev); // ← dev
  await configureDependencies();
  runApp(const App());
}
```

```dart
// apps/nudishous_app/lib/main_prod.dart
import 'package:firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize(Flavor.prod); // ← prod
  await configureDependencies();
  runApp(const App());
}
```

---

## Melos Scripts

```yaml
# melos.yaml
scripts:
  run:dev:
    run: |
      cd apps/nudishous_app && flutter run \
        --flavor dev \
        --target lib/main_dev.dart
    description: Run flavor dev

  run:prod:
    run: |
      cd apps/nudishous_app && flutter run \
        --flavor prod \
        --target lib/main_prod.dart
    description: Run flavor prod

  build:apk:dev:
    run: |
      cd apps/nudishous_app && flutter build apk \
        --flavor dev \
        --target lib/main_dev.dart
    description: Build APK dev

  build:apk:prod:
    run: |
      cd apps/nudishous_app && flutter build apk \
        --release \
        --flavor prod \
        --target lib/main_prod.dart
    description: Build APK prod

  build:ios:dev:
    run: |
      cd apps/nudishous_app && flutter build ios \
        --flavor dev \
        --target lib/main_dev.dart
    description: Build iOS dev

  build:ios:prod:
    run: |
      cd apps/nudishous_app && flutter build ios \
        --release \
        --flavor prod \
        --target lib/main_prod.dart
    description: Build iOS prod

  flutterfire:dev:
    run: |
      cd apps/nudishous_app && flutterfire configure \
        --project=nudishous-dev \
        --out=lib/firebase_options_dev.dart \
        --platforms=android,ios \
        --android-app-id=id.midosaurus.nudishous.dev \
        --ios-bundle-id=id.midosaurus.nudishous.dev
    description: Config FlutterFire untuk DEV

  flutterfire:prod:
    run: |
      cd apps/nudishous_app && flutterfire configure \
        --project=nudishous-prod \
        --out=lib/firebase_options_prod.dart \
        --platforms=android,ios \
        --android-app-id=id.midosaurus.nudishous \
        --ios-bundle-id=id.midosaurus.nudishous
    description: Config FlutterFire untuk PROD
```

---

## Jalankan Sekarang

```bash
# Dari root workspace
melos run flutterfire:dev
melos run flutterfire:prod

# Lalu pindahkan file generated ke firebase_service package
# kemudian run
melos run run:dev
```

---

## `.gitignore` — Jangan Commit Firebase Options!

```gitignore
# packages/data/firebase_service/.gitignore
lib/src/config/firebase_options/firebase_options_dev.dart
lib/src/config/firebase_options/firebase_options_prod.dart

# apps/nudishous_app/.gitignore  
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

Simpan `firebase_options` di **environment secrets** CI/CD, bukan di git!

Mau lanjut ke setup Android flavor di `build.gradle` dan iOS scheme di Xcode agar `--flavor dev` dan `--flavor prod` bisa jalan?