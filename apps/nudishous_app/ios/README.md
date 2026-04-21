Konfigurasi iOS sedikit berbeda dengan Android. Jika Android menggunakan folder flavor (`src/dev`, `src/prod`) yang sudah otomatis dikenali Gradle, Xcode tidak memiliki sistem *source set* yang sama. Kita harus menggunakan **Build Configurations** dan **Shell Script** untuk menukar file `.plist` secara otomatis.

Sebagai **Senior Developer**, berikut adalah cara "Enterprise" untuk mengaturnya agar sinkron dengan flavor `.dev` dan `.prod` Anda:

---

### 1. Struktur Folder di Xcode
Jangan menaruh file `.plist` di root folder `ios/Runner`. Buatlah struktur folder seperti ini di dalam folder `Runner`:

```text
ios/Runner/
├── Firebase/
│   ├── Dev/
│   │   └── GoogleService-Info.plist (Paket ID: id.midosaurus.nudishous.dev)
│   └── Prod/
│       └── GoogleService-Info.plist (Paket ID: id.midosaurus.nudishous)
```

**Penting:** Saat memasukkan file ini ke Xcode, **jangan** centang (uncheck) bagian **"Target Membership"**. Kita tidak ingin file ini masuk ke bundle aplikasi secara permanen; kita hanya ingin script kita yang mengambilnya nanti.

---

### 2. Buat Build Configurations di Xcode
Anda perlu menduplikasi konfigurasi `Debug`, `Release`, dan `Profile` untuk masing-masing flavor.

1. Buka `Runner.xcworkspace` di Xcode.
2. Pilih project **Runner** (ikon biru paling atas).
3. Di tab **Info**, pada bagian **Configurations**, duplikasi konfigurasi yang ada:
    * `Debug` -> `Debug-dev` dan `Debug-prod`
    * `Release` -> `Release-dev` dan `Release-prod`
    * (Lakukan hal yang sama untuk `Profile` jika perlu).



---

### 3. Buat "Run Script" untuk Menukar File
Ini adalah bagian paling krusial. Script ini akan berjalan setiap kali Anda menekan "Run" atau "Build" dan akan menyalin file yang benar ke folder tujuan.

1. Di Xcode, pilih **Target Runner**.
2. Pergi ke tab **Build Phases**.
3. Klik tanda **+** lalu pilih **New Run Script Phase**.
4. Namakan script ini: **"Setup Firebase Environment"**.
5. Letakkan script ini **di atas** "Compile Sources".
6. Masukkan script berikut:

```bash
# Tentukan lokasi folder Firebase berdasarkan Build Configuration
if [[ $CONFIGURATION == *"dev"* ]]; then
    CP_PATH="${SRCROOT}/Runner/Firebase/Dev/GoogleService-Info.plist"
else
    CP_PATH="${SRCROOT}/Runner/Firebase/Prod/GoogleService-Info.plist"
fi

# Lokasi tujuan di dalam aplikasi yang sudah ter-build
TARGET_PATH="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

# Lakukan penyalinan
if [ -f "$CP_PATH" ]; then
    cp "$CP_PATH" "$TARGET_PATH"
    echo "Firebase: Copied $CP_PATH to $TARGET_PATH"
else
    echo "Firebase: Error! $CP_PATH not found."
    exit 1
fi
```



---

### 4. Sesuaikan Bundle Identifier
Agar identitas aplikasi berubah sesuai flavor (sama seperti `applicationIdSuffix` di Android):

1. Masih di Xcode Target Runner, buka tab **Build Settings**.
2. Cari **Product Bundle Identifier**.
3. Klik tanda panah untuk melihat daftar konfigurasi.
4. Ubah nilainya:
    * **Debug-dev, Release-dev**: `id.midosaurus.nudishous.dev`
    * **Debug-prod, Release-prod**: `id.midosaurus.nudishous`

---

### 5. Menjalankan via Flutter CLI
Setelah setup di Xcode selesai, Anda tinggal menjalankan perintah Flutter dengan flag `--flavor`:

```bash
# Untuk Development
flutter run --flavor dev --target lib/main_dev.dart

# Untuk Production
flutter run --flavor prod --target lib/main_prod.dart
```

---

### Mengapa Harus Pakai Script?

iOS (Xcode) membutuhkan satu file bernama `GoogleService-Info.plist` yang berada tepat di root aplikasi saat runtime. Karena Firebase SDK versi iOS akan mencari file dengan nama itu secara spesifik saat inisialisasi (`FirebaseApp.configure()`). Dengan script di atas, kita memastikan file yang "benar" selalu berganti nama menjadi `GoogleService-Info.plist` tepat sebelum aplikasi dijalankan.

### Tips Pro:
Jika Anda menggunakan **Firebase Crashlytics**, jangan lupa bahwa Crashlytics juga membutuhkan script terpisah untuk upload simbol debug (`dSYM`). Pastikan script Crashlytics Anda diletakkan **setelah** script "Setup Firebase Environment" agar ia membaca file `.plist` yang sudah ter-update.

Apakah Anda sudah menyesuaikan **Bundle ID** di Firebase Console untuk versi iOS `.dev` Anda? Sama seperti Android, iOS juga butuh pendaftaran App ID yang unik di dalam project Firebase.