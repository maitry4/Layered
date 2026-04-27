# app_router.dart

## Overview
`app_router.dart` configures the navigation system of the application using the `go_router` package. It defines the routing table, initial location, error handling, and redirection logic.

## Implementation Details
1.  **GoRouter Configuration**: Creates a global `appRouter` instance.
2.  **Route Definitions**: Maps URL paths to specific Screen widgets.
3.  **Redirection Logic**: Implements guard rails (e.g., forcing onboarding if not seen, or preventing access to locked levels).
4.  **Error Handling**: Uses a custom `ErrorPage` for invalid routes or exceptions.

## Code Breakdown

### 1. Initial Location & Error Handling
```dart
initialLocation: AppRoutes.splash,
errorBuilder: (context, state) => ErrorPage(error: state.error),
```
*   Sets the starting point of the app and how to handle navigation errors.

### 2. Onboarding Redirect
```dart
redirect: (context, state) {
  final seen = HiveService.instance.hasSeenOnboarding;
  if (seen) {
    return AppRoutes.gameMap;
  }
  return null; 
},
```
*   If the user has already seen the onboarding, they are automatically sent to the `gameMap` when attempting to visit the onboarding page.

### 3. Game Play Route with Level Validation
```dart
GoRoute(
  path: AppRoutes.gamePlay,
  redirect: (context, state) {
    final level = int.tryParse(state.uri.queryParameters['level'] ?? '') ?? 1;
    final unlocked = HiveService.instance.unlockedUpTo;
    if (level > unlocked) {
      return '${AppRoutes.gamePlay}?level=$unlocked';
    }
    return null;
  },
  builder: (context, state) { ... },
)
```
*   Extracts the `level` from query parameters.
*   Checks if the requested level is unlocked via `HiveService`.
*   If the user tries to access a locked level, it redirects them to the highest unlocked level.
