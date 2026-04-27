# game_map_screen.dart

## Overview
`game_map_screen.dart` is the container for the map view. It initializes the `GameMapCubit` and triggers the data load.

## Implementation Details
1.  **BlocProvider**: Scopes the cubit to the map feature.
2.  **Cascading Load**: Uses the `..load()` cascade operator to immediately start loading progress data when the cubit is created.

## Code Breakdown

### 1. Composition
```dart
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => GameMapCubit()..load(),
    child: const GameMapView(),
  );
}
```
*   Wraps the actual view widget (`GameMapView`) with the required business logic provider.
