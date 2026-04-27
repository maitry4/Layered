# splash_cubit.dart

## Overview
`splash_cubit.dart` handles the logic for the initial loading screen, including asset selection and route determination.

## Implementation Details
1.  **Responsive Assets**: Selects different splash images based on screen width (Mobile vs. Desktop).
2.  **Image Pre-caching**: Uses `precacheImage` to ensure the splash image is ready before being displayed, preventing flickering.
3.  **Routing Logic**: Determines whether to go to `onboarding` or `gameMap` based on `HiveService` data.

## Code Breakdown

### 1. Asset Resolution
```dart
String _resolveAsset(double screenWidth) {
  return screenWidth >= AppBreakpoints.mobile
      ? 'assets/splash/splash_desktop.webp'
      : 'assets/splash/splash_mobile.webp';
}
```
*   Provides a simple logic to switch between mobile and desktop-optimized assets.

### 2. `loadSplash()` Method
```dart
Future<void> loadSplash(BuildContext context) async {
  emit(SplashLoading());
  try {
    final asset = _resolveAsset(screenWidth);
    await precacheImage(AssetImage(asset), context);
    final targetRoute = HiveService.instance.hasSeenOnboarding ? AppRoutes.gameMap : AppRoutes.onboarding;
    emit(SplashReady(assetPath: asset, targetRoute: targetRoute));
  } catch (e) {
    emit(SplashError(message: e.toString()));
  }
}
```
*   Orchestrates the loading sequence: loading -> precaching -> ready.
