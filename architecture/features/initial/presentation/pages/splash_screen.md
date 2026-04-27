# splash_screen.dart

## Overview
`splash_screen.dart` provides a cinematic entry point into the app, featuring a slow-zooming background image.

## Implementation Details
1.  **State Management**: Uses `SplashCubit` to handle initialization logic.
2.  **Animations**: Implements a `TweenAnimationBuilder` for a "Ken Burns" style slow zoom effect.
3.  **Error Handling**: Displays a user-friendly error view if loading fails.
4.  **Delayed Navigation**: Waits for a few seconds (cinematic duration) before moving to the next screen.

## Code Breakdown

### 1. Initialization Trigger
```dart
void didChangeDependencies() {
  if (!_initialized) {
    _initialized = true;
    context.read<SplashCubit>().loadSplash(context);
  }
}
```
*   Ensures loading starts as soon as the dependencies are available.

### 2. Zoom Animation
```dart
TweenAnimationBuilder<double>(
  duration: const Duration(milliseconds: 3500),
  tween: Tween(begin: 1.0, end: 1.1),
  builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
  child: Image.asset(assetPath, fit: BoxFit.cover),
)
```
*   Creates a dynamic, premium feel by slowly scaling the splash image.
