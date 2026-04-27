# game_map_cubit.dart

## Overview
`game_map_cubit.dart` manages the state of the level selection map. It is responsible for loading the user's progress and informing the UI about which levels are unlocked.

## Implementation Details
1.  **State Loading**: Fetches the `unlockedUpTo` value from `HiveService`.
2.  **Simple Lifecycle**: Moves from a `Loading` state to a `Loaded` state once the data is retrieved.

## Code Breakdown

### 1. `load()` Method
```dart
void load() {
  final unlocked = HiveService.instance.unlockedUpTo;
  emit(GameMapLoaded(unlockedUpTo: unlocked));
}
```
*   Directly interacts with the persistence layer to get the current player's progress and updates the state.
