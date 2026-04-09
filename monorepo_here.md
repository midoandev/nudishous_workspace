1. Command Line Setup (Jalankan di Terminal)
     1. Buat folder root dan masuk ke dalamnya
    mkdir nudishous_workspace && cd nudishous_workspace
    
     2. Inisialisasi Git
    git init
    
     3. Buat struktur folder utama
    mkdir -p apps packages/core packages/data packages/features
    
     4. Inisialisasi Runner App (Aplikasi Utama)
    flutter create --org id.midosaurus --project-name nudishous apps/nudishous_app
    
     5. Inisialisasi Core Packages
    flutter create --template=package packages/core/core_logic
    flutter create --template=package packages/core/core_ui
    
     6. Inisialisasi Data Packages
    flutter create --template=package packages/data/openfood_api
    
     7. Inisialisasi Features Packages (MVP)
    flutter create --template=package packages/features/sandbox
    
     8. Buat file konfigurasi Melos dan README
    touch melos.yaml README.md
    
     9. Install Melos secara global (jika belum)
    dart pub global activate melos

2. Konfigurasi melos.yaml
    name: nudishous_workspace
    packages:
        - apps/**
        - packages/**
    
    scripts:
    analyze:
    exec: flutter analyze .
    description: Menjalankan flutter analyze di semua package.
    
    test:
    exec: flutter test
    description: Menjalankan flutter test di semua package yang memiliki folder test.
    
    clean:
    exec: flutter clean
    description: Membersihkan build files di seluruh workspace.
    
    format:
    exec: dart format .
    description: Melakukan formatting kode di seluruh workspace.

3. dart pub global activate melos
4. Buat File pubspec.yaml di Root Workspace
   name: nudishous_workspace
   publish_to: none

    environment:
    sdk: ^3.11.0
    
    workspace:
        - apps/nudishous_app
        - packages/core/core_logic
        - packages/core/core_ui
        - packages/data/openfood_api
        - packages/features/sandbox

5. Tambahkan resolution: workspace di Semua Paket
   name: nudishous_app
   description: "A new Flutter project."
   publish_to: 'none'
   **resolution: workspace** # <-- Tambahkan baris ini

    version: 1.0.0+1
     ... lanjutannya tetap sama
   (Lakukan hal yang sama untuk core_logic, core_ui, openfood_api, dan sandbox).

6. Eksekusi Bootstrap
    Setelah semuanya diubah, jalankan kembali perintah andalan kita di terminal root:
    cmd: melos bootstrap

7. Menambahkan Skrip generate ke Melos
   Buka file melos.yaml Anda, dan tambahkan skrip generate di bawah blok scripts: yang sudah ada sebelumnya:
   scripts:
    ... (analyze, test, clean, format yang sudah ada)
    
Tambahkan ini:
    generate:
    run: melos exec -c 1 --depends-on build_runner -- "dart run build_runner build --delete-conflicting-outputs"
    description: Menjalankan build_runner di semua package yang membutuhkannya.

8. Mengisi "Nyawa" ke core_logic
    bash: melos exec --scope="core_logic" -- "flutter pub add flutter_bloc equatable"
   Perintah di atas menyuruh Melos: "Tolong jalankan flutter pub add... tapi hanya di dalam paket core_logic."
    _packages/core/core_logic/lib/base_state.dart_
   `import 'package:equatable/equatable.dart';

    abstract class BaseState extends Equatable {
    const BaseState();
    
    @override
    List<Object?> get props => [];
    }
    
    class InitialState extends BaseState {}
    
    class LoadingState extends BaseState {}
    
    class ErrorState extends BaseState {
    final String message;
    
    const ErrorState(this.message);
    
    @override
    List<Object?> get props => [message];
    }`

9. Mengisi "Warna" ke core_ui (Design System)
   melos exec --scope="core_ui" -- "flutter pub add google_fonts"
   _packages/core/core_ui/lib/app_colors.dart_
   import 'package:flutter/material.dart';

    class AppColors {
    // Primary - Sage Green Tone
    static const Color primary = Color(0xFF8A9A5B);
    static const Color primaryDark = Color(0xFF6F7D46);
    static const Color primaryLight = Color(0xFFE8ECE2);
    
    // Accent - Terracotta (Untuk Nafsu Makan / Warning)
    static const Color accent = Color(0xFFE2725B);
    
    // Backgrounds & Neutrals
    static const Color background = Color(0xFFFAFAF5);
    static const Color surface = Color(0xFFFFFFFF);
    static const Color textMain = Color(0xFF2D3436);
    static const Color textSecondary = Color(0xFF888888);
    
    // Status Colors (Untuk Indikator Nutrisi)
    static const Color statusHealthy = Color(0xFF82E0AA); // Hijau
    static const Color statusWarning = Color(0xFFF1C40F); // Kuning
    static const Color statusDanger = Color(0xFFE74C3C);  // Merah
    }

10. Langkah 1: Setup Dependensi di openfood_api
    melos exec --scope="openfood_api" -- "flutter pub add openfoodfacts"
11. Langkah 2: Membuat "Nutrient Sanitizer" di openfood_api
    _Buat file baru di packages/data/openfood_api/lib/src/models/food_dto.dart:_
    `import 'package:openfoodfacts/openfoodfacts.dart';

    /// Extension untuk membersihkan data mentah dari API
    extension ProductSanitizer on Product {
    double get safeCalories => nutriments?.getValue(Nutrient.energyKcal, PerSize.oneHundredGrams) ?? 0.0;
    double get safeProtein => nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0;
    double get safeCarbs => nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0.0;
    double get safeFat => nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0;
    
    String get safeImageUrl => imageFrontUrl ?? "";
    String get safeName => productName ?? "Produk Tanpa Nama";
    }`
12. Langkah 3: Menghubungkan Paket (The "Wiring" Phase)
    _packages/features/sandbox/pubspec.yaml_
    name: sandbox
     ...
    resolution: workspace
    
    dependencies:
    flutter:
    sdk: flutter
    flutter_bloc: ^8.1.0
    
    ...Dependensi Internal Monorepo
    core_logic: any
    core_ui: any
    openfood_api: any
13. melos bs 'di terminal root untuk menautkan semuanya secara permanen'
14. Langkah 4: Merancang "Sandbox Cubit" (Logika Utama)
15. Enable Dart Support: * Centang "Enable Dart support for the project 'nudishous_workspace'".

    Pada Dart SDK path, arahkan ke folder SDK Flutter Anda. Contoh: /Users/nama_user/flutter/bin/cache/dart-sdk.
    
    Navigasi ke Flutter: Tepat di bawah menu Dart, pilih Flutter.
    
    Isi Flutter SDK path dengan lokasi folder utama Flutter Anda. Contoh: /Users/nama_user/flutter.
16. Membuat Aplikasi "Running" (Wiring the MVP)Membuat Aplikasi "Running" (Wiring the MVP)
    Langkah A: Update apps/nudishous_app/pubspec.yaml
    Tambahkan sandbox dan flutter_bloc ke aplikasi utama.
    `dependencies:
    flutter:
    sdk: flutter
    ..Hubungkan ke feature package
    sandbox: any
    flutter_bloc: ^8.1.0
    core_ui: any
    core_logic: any
    
    resolution: workspace`
    Jangan lupa jalankan melos bs di terminal root setelah mengubah ini.

    Langkah B: Edit apps/nudishous_app/lib/main.dart
    `import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:sandbox/sandbox.dart'; // Import feature sandbox
    import 'package:core_ui/app_colors.dart'; // Import design system

    void main() {
    runApp(const NudishousApp());
    }
    
    class NudishousApp extends StatelessWidget {
    const NudishousApp({super.key});
    
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Nudishous',
    theme: ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    ),
    // Membungkus SandboxPage dengan Cubit-nya
    home: BlocProvider(
    create: (context) => SandboxCubit(),
    child: const SandboxPage(),
    ),
    );
    }
    }`

    Langkah C: Siapkan UI Sederhana di sandbox
    `import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import '../../cubits/sandbox_cubit.dart';
    import '../../cubits/sandbox_state.dart';
    import 'package:core_ui/app_colors.dart';

    class SandboxPage extends StatelessWidget {
    const SandboxPage({super.key});
    
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: const Text('Nudishous Sandbox'),
    backgroundColor: AppColors.primary,
    ),
    body: BlocBuilder<SandboxCubit, SandboxUpdated>(
    builder: (context, state) {
    return Column(
    children: [
    // Scoreboard Sederhana
    Container(
    padding: const EdgeInsets.all(20),
    color: AppColors.primaryLight,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Text('Kalori: ${state.totalCalories.toStringAsFixed(0)}'),
    Text('Protein: ${state.totalProtein.toStringAsFixed(0)}g'),
    ],
    ),
    ),
    const Expanded(
    child: Center(child: Text('Piring Digital Siap Diracik!')),
    ),
    ],
    );
    },
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    // Trigger tambah bahan dummy untuk tes reaktivitas
    context.read<SandboxCubit>().tambahBahan(
    const FoodItem(id: '1', name: 'Ayam', calories: 165, protein: 31),
    );
    },
    backgroundColor: AppColors.accent,
    child: const Icon(Icons.add),
    ),
    );
    }
    }`