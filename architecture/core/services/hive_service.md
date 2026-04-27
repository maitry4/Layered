# hive_service.dart

## Overview
`hive_service.dart` is the data access layer for local persistence. It wraps the `hive` package to provide a clean API for saving and retrieving user progress and preferences.

## Implementation Details
1.  **Singleton Pattern**: Access via `HiveService.instance` ensures a single point of interaction.
2.  **Encapsulation**: Boxes and keys are private, preventing other parts of the app from interacting with Hive directly.
3.  **Initialization**: `init()` must be called at startup to open the necessary boxes.
4.  **Typed Access**: Provides getter and setter methods for specific data (e.g., `hasSeenOnboarding`, `unlockedUpTo`).

## Code Breakdown

### 1. Boxes and Keys
```dart
static const _kOnboardingBox = 'onboarding';
static const _kProgressBox   = 'progress';
static const _kSeenOnboardingKey = 'has_seen_onboarding';
```
*   Defines where and how data is stored on disk.

### 2. Initialization
```dart
static Future<void> init() async {
  await Hive.initFlutter();
  final self = HiveService.instance;
  self._onboardingBox = await Hive.openBox<bool>(_kOnboardingBox);
  self._progressBox   = await Hive.openBox<int>(_kProgressBox);
}
```
*   Prepares the database and opens the boxes for reading/writing.

### 3. Progress Management
```dart
int get unlockedUpTo => _progressBox.get(_kUnlockedUpToKey, defaultValue: 1) ?? 1;

Future<void> unlockNextLevel(int completedLevel) async {
  if (completedLevel >= unlockedUpTo) {
    await _progressBox.put(_kUnlockedUpToKey, completedLevel + 1);
  }
}
```
*   `unlockedUpTo`: Retrieves the highest level reached.
*   `unlockNextLevel`: Increments the progress only if the user completes their current highest level.
