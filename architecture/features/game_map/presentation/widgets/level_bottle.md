# level_bottle.dart

## Overview
`level_bottle.dart` is the interactive level marker on the map. It represents a single level and allows the user to navigate to the gameplay screen.

## Implementation Details
1.  **Press Animation**: Implements a `ScaleTransition` using an `AnimationController` to shrink the bottle slightly when tapped, providing tactile feedback.
2.  **Locked/Unlocked Logic**: Checks if the level is unlocked before allowing navigation or showing the level badge.
3.  **Asset Tints**: Applies a semi-transparent surface color overlay to the bottle asset if it's locked.
4.  **Navigation**: Uses `context.goNamed` with query parameters to pass the `levelNumber` to the game play screen.

## Code Breakdown

### 1. Tap Logic
```dart
Future<void> _onTap(BuildContext context) async {
  if (!widget.isUnlocked) return;
  await _ctrl.forward();
  await _ctrl.reverse();
  context.goNamed(AppRoutes.gamePlay, queryParameters: {'level': ...});
}
```
*   Ensures only unlocked levels are interactive. Runs a "bump" animation before navigating.

### 2. `_BottleImage` Widget
```dart
color: isUnlocked ? null : Theme.of(context).colorScheme.surface.withOpacity(0.65),
colorBlendMode: isUnlocked ? null : BlendMode.modulate,
```
*   Uses `ColorFilter` (via `color` and `colorBlendMode` properties of `Image.asset`) to visually "disable" locked bottles without needing a separate grayscale asset.
