# 🥗 Nudishous - Modular Monorepo

[](https://flutter.dev)
[](https://dart.dev)
[](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[](https://opensource.org/licenses/MIT)

**Nudishous** is a smart nutrition planning platform that allows users to craft their own "Digital Bowl." This project demonstrates a production-grade implementation of a **Modular Monorepo** in Flutter, ensuring the application is scalable, testable, and maintainable.

-----

## 🚀 Key Features

* **Digital Sandbox**: Real-time macro-nutrient calculation and simulation.
* **Global Food Database**: Deep integration with the OpenFoodFacts API.
* **Modular Architecture**: Independent feature modules for parallel development.
* **Flavor Support**: Isolated configurations for `Development` and `Production` environments.

-----

## 🏗️ Project Architecture

This project follows a **Modular Clean Architecture** approach, enforcing strict layer boundaries to prevent technical debt and "spaghetti code."

### Workspace Structure

| Layer | Path | Primary Responsibility |
| :--- | :--- | :--- |
| **Apps** | `apps/` | Main application entry points and platform-specific flavor configurations. |
| **Features** | `packages/features/` | Self-contained business features (e.g., `sandbox`, `auth`). |
| **Core** | `packages/core/` | Global logic, Design System (`core_ui`), and shared utilities. |
| **Data** | `packages/data/` | Shared data sources (API Clients, Firebase, Local Storage). |

-----

## 🛠️ Tech Stack

* **Framework**: Flutter SDK ^3.11.0
* **Workspace Manager**: [Melos](https://melos.invertase.dev/)
* **State Management**: Bloc / Cubit
* **Dependency Injection**: Transitive Exports via Core Logic
* **Code Generation**: Build Runner (for models & serialization)

-----

## 🚦 Getting Started

### 1\. Install Melos

Ensure Melos is installed globally on your machine to manage the workspace:

```bash
dart pub global activate melos
```

### 2\. Bootstrapping

Run the following command at the root directory to install all dependencies and link modular packages automatically:

```bash
melos bs
```

### 3\. Running the App (Flavors)

Use the predefined Melos scripts to run the application in your preferred environment:

* **Development Mode**:
  ```bash
  melos run dev
  ```
* **Production Mode**:
  ```bash
  melos run prod
  ```

-----

## 📜 Automation Scripts (Melos)

| Command | Description |
| :--- | :--- |
| `clean` | Sequentially clears build artifacts across all packages. |
| `analyze` | Runs static analysis to maintain code quality standards. |
| `generate` | Triggers `build_runner` for all packages requiring code generation. |
| `format` | Standardizes code formatting across the entire workspace. |

-----

> **Note**: This project is under active development. Always run `melos bs` after pulling the latest changes to ensure your local workspace is synchronized.

-----