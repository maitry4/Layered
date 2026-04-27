# game_map_state.dart

## Overview
`game_map_state.dart` defines the states for the game map screen.

## Implementation Details
1.  **Sealed Class**: For type-safe state handling.
2.  **Data Carrying**: `GameMapLoaded` carries the `unlockedUpTo` integer, which is critical for rendering the map correctly.

## Code Breakdown

### 1. `GameMapLoaded` State
```dart
final class GameMapLoaded extends GameMapState {
  final int unlockedUpTo;
  ...
}
```
*   Ensures that the UI has the necessary information to distinguish between locked and unlocked bottles.
