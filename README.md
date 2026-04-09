# Nudishous - The Nutritional Sandbox 🥗

Nudishous adalah aplikasi mobile *intelligent kitchen sandbox* yang memungkinkan pengguna meracik bahan makanan secara visual dan melihat kalkulasi nutrisi secara *real-time*.

Proyek ini dibangun menggunakan **Flutter** dan dikelola dalam arsitektur **Modular Monorepo** menggunakan **Melos** untuk memastikan skalabilitas, separasi *logic*, dan kemudahan *testing*.

## 🏗️ Architecture & Project Structure

Proyek ini dipisahkan menjadi beberapa *packages* independen:

```text
nudishous_workspace/
├── apps/
│   └── nudishous_app/      # Main application runner & Dependency Injection (DI)
└── packages/
    ├── core/
    │   ├── core_logic/     # Core utils, Base Cubit, Network Client, Constants
    │   └── core_ui/        # Design System (Colors, Typography, Custom Widgets)
    ├── data/
    │   └── openfood_api/   # OpenFoodFacts API wrapper & Data Sanitization layer
    └── features/
        └── sandbox/        # Core Feature: Digital Bowl, Macro Kalkulator & Search