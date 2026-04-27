# game_map_view.dart

## Overview
`game_map_view.dart` is the top-level UI widget for the map. it handles the transition between loading and content states.

## Implementation Details
1.  **State Switching**: Uses a `switch` statement on the cubit state to show either a loading spinner or the map content.
2.  **Entrance Animation**: Uses a `TweenAnimationBuilder` to create a subtle scale-in effect (zoom out from 1.1 to 1.0) when the map screen appears.

## Code Breakdown

### 1. State Switching Logic
```dart
child: switch (state) {
  GameMapLoading() => const _LoadingView(),
  GameMapLoaded(:final unlockedUpTo) => MapContent(unlockedUpTo: unlockedUpTo),
},
```
*   Reactively updates the UI based on the `GameMapCubit` state.
