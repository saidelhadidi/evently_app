# 🌟 Evently App

> 🚧 **Note:** This project is currently under active development (Work In Progress). New features, UI enhancements, and functionalities are being pushed regularly!

**Evently** is a modern, intuitive event discovery and planning application built with Flutter. It empowers users to find events that inspire them, seamlessly plan their own gatherings, and connect with friends to share unforgettable moments.

---

## ✨ Features & Technical Achievements

### 1. 🎨 Global Theming & Dynamic UI
* **Dynamic Theme Toggling:** Seamless switching between **Light** and **Dark** modes utilizing a robust, centralized `AppTheme` architecture (`colorScheme`, `inputDecorationTheme`).
* **Smart UI Components:** Custom built, theme-aware widgets (e.g., `ToggleSwitch`, `CustomBackButton`, `EventCard`) that adapt their borders, backgrounds, images, and text colors dynamically based on the active theme.
* **Dynamic SVG Coloring:** Implemented seamless theme transitions for vector graphics using `ColorFilter` and `BlendMode.srcIn` to avoid pixelation and hardcoded colors.
* **Custom Typography:** Integrated and properly configured the **Poppins** font family globally across the application for a premium feel.

### 2. 🔐 Secure Authentication & Firebase Integration
* **Firebase Auth:** Robust signup and login system integrated with **Firebase Authentication**.
* **Security Best Practices:** Implemented generic error messaging ("Invalid email or password") to prevent email enumeration, following industry standards (like Facebook/Instagram).
* **Smart Validation:** Real-time, localized form validation using Flutter's `Form` and `TextFormField` widgets, providing instant feedback directly under the fields.
* **UX Enhancements:** Optimized keyboard interactions with `textInputAction` (Next/Done) and `onFieldSubmitted` for a fast, "native" feel. Used `ExcludeFocus` to ensure smooth focus traversal.

### 3. 🧠 Advanced State & Memory Management
* **Clean Architecture:** Strictly separated the UI (Presentation) from Business Logic using `StatelessWidget` and `Provider` (`ChangeNotifier`).
* **Provider Scoping:** Strategically placed local providers (e.g., `AuthProvider`, `HomeProvider`) specifically within the widget trees that require them to ensure optimal memory management.
* **Async Gap Protection:** Implemented rigorous `mounted` and `context.mounted` checks across all asynchronous operations to prevent crashes and memory leaks.

### 4. 💾 Local Data Persistence & User Profile
* **Persistent Login State:** Integrated `shared_preferences` to keep users logged in across sessions.
* **User-Specific Profiles:** Implemented a profile picture management system with **Image Picking** and **Cropping** (1:1 aspect ratio). Pictures are persisted locally using the user's email as a unique key.
* **Smart Traffic Routing:** A dynamic `SplashScreen` checks the device's state to route users instantly to Onboarding, Login, or the Home screen based on their history.

### 5. 🌐 Reactive Localization (EN/AR)
* **Dynamic Content:** Solved translation "lag" by using **getters** for all data-driven lists (Categories, Onboarding), ensuring UI updates instantly when the language toggles.
* **Full Arabic Support:** Completely localized the app into Arabic, including RTL layout adaptation and all validation/error messages.
* **StringsManager:** Centralized resource management using `easy_localization` for a clean and scalable code base.

---

## 📱 Screenshots

*(Note: These are initial previews. UI is subject to enhancements as development continues.)*

| Splash & Routing | Start Screen (Light) | Start Screen (Dark) |
|:---:|:---:|:---:|
| <img src="assets/readme/splash.png" width="250"> | <img src="assets/readme/start_light.png" width="250"> | <img src="assets/readme/start_dark.png" width="250"> |

| Onboarding 1 | Onboarding 2 | Onboarding 3 |
|:---:|:---:|:---:|
| <img src="assets/readme/onboarding_1.png" width="250"> | <img src="assets/readme/onboarding_2.png" width="250"> | <img src="assets/readme/onboarding_3.png" width="250"> |

---

## 🛠️ Tech Stack & Architecture

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** Dart
* **Backend:** [Firebase](https://firebase.google.com/) (Authentication)
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Key Packages:** `firebase_auth`, `easy_localization`, `image_picker`, `image_cropper`, `shared_preferences`, `smooth_page_indicator`, `flutter_svg`.
* **Architecture:** Feature-first modular approach (`core/`, `features/`, `providers/`) emphasizing **Separation of Concerns**, **DRY**, and **Clean Code** principles.

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (Latest stable version)
* Firebase Project Setup

### Installation
1. Clone the repo:
   ```sh
   git clone https://github.com/saidelhadidi/evently_app.git
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

---

## 👨‍💻 Author

**Said Elhadidi** *GDGoC Egypt Facilitator & Mobile Developer* [LinkedIn](https://www.linkedin.com/in/saidelhadidi/) | [GitHub](https://github.com/saidelhadidi)
