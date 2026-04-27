# app_routes.dart

## Overview
`app_routes.dart` provides a centralized list of string constants representing the route paths in the application.

## Implementation Details
1.  **Static Constants**: Simple string constants for route names to avoid typos across the app.

## Code Breakdown

### 1. Route Path Constants
```dart
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String gameMap = '/game-map';
  static const String gamePlay = '/game-play';
}
```
*   `splash`: Root path.
*   `onboarding`: Intro screens.
*   `gameMap`: The level selection screen.
*   `gamePlay`: The actual gameplay screen.
