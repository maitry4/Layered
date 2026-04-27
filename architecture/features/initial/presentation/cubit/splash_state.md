# splash_state.dart

## Overview
`splash_state.dart` defines the states for the splash screen initialization lifecycle.

## Implementation Details
1.  **Sealed Class**: Ensures exhaustive state handling.
2.  **State Variety**: Includes `Initial`, `Loading`, `Ready`, and `Error` states.

## Code Breakdown

### 1. `SplashReady` State
```dart
final class SplashReady extends SplashState {
  final String assetPath;
  final String targetRoute;
  ...
}
```
*   Contains the path to the loaded image and the destination route for the next transition.
