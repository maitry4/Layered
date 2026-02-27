# 🧩 Layered

A cross-platform puzzle game built with Flutter, designed to demonstrate clean layered architecture and structured state management using BLoC.

Layered challenges players to sort stacked slabs into bottles following strict stacking rules across 100 progressively difficult levels — fully offline.

> The name **Layered** reflects both the stacking-based gameplay mechanics and the layered architectural pattern used in the codebase.

---

<!-- ## 📱 UI Preview

<!-- Add screenshots here -->

--- -->

## 🚀 Features

### 🎮 Core Gameplay
- 100 progressively challenging levels
- Water-sort-inspired stacking mechanics
- Strict move validation rules
- Undo functionality with state tracking
- Level reset support
- Automatic win detection
- Loss detection when no valid moves remain

### 🗺 Progression System
- Interactive roadmap-based level selection
- Sequential level unlocking
- Replay completed levels
- Continue from last unlocked level

### 💾 Offline-First Design
- Fully functional without internet
- Local progress persistence
- Game state storage
- Settings management

### 🎨 User Experience
- Animated splash screen
- First-time onboarding flow
- Responsive layout (Android, iOS, Web, Desktop)
- Custom-designed slab and bottle assets

---

## 🏗 Architecture

Layered follows a **feature-based layered architecture**, ensuring separation of concerns and maintainability.

Each feature is structured into:

- **Presentation Layer** – UI and BLoC state management
- **Domain Layer** – Core game logic and rules
- **Data Layer** – Local storage and persistence

### Feature Structure

```
features/
 └── feature_name/
      ├── data/
      ├── domain/
      └── presentation/
```

This structure enables:
- Clear dependency flow
- Testable business logic
- Scalable feature expansion
- Easier long-term maintenance

---

## 🧠 State Management

**BLoC** (Business Logic Component)
- Deterministic state transitions
- Clear event → state mapping
- Predictable UI updates

---

## 💾 Persistence

**Hive** (Lightweight NoSQL local storage)
- Fast read/write performance
- Offline-first data handling
- Structured progress tracking

---

## 🛠 Tech Stack

| Area | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| Architecture | Feature-based Layered Architecture |
| State Management | BLoC |
| Local Storage | Hive |
| Utilities | Equatable, Path Provider, Google Fonts |
| Platforms | Android, iOS, Web, Desktop |

---

## 📂 Project Structure

```
lib/
│── main.dart
│
├── core/
│   ├── constants/
│   ├── game_config/
│   ├── responsive/
│   ├── themes/
│   └── widgets/
│
└── features/
    ├── game_map/
    ├── game_play/
    └── initial/
```

---

## 🎯 Engineering Highlights

- Deterministic move validation engine
- Stack-based puzzle state model
- Undo stack management
- Win/Loss evaluation logic
- Persistent progression system
- Clean separation between UI and domain logic

---

## 🧪 Testing

The core game logic is designed to be testable independently from the UI layer, enabling validation of:

- Move legality
- Win detection
- Loss scenarios
- Undo behavior

---

## 🚀 Getting Started

```bash
git clone https://github.com/maitry4/Layered.git
cd layered
flutter pub get
flutter run
```

---

## 📌 Future Enhancements

- Cloud-based progress sync
- Additional level packs
- Advanced difficulty modes
- Accessibility improvements

---

## 📄 License

Developed for academic and learning purposes.