# bottle_widget.dart

## Overview
`bottle_widget.dart` is the visual representation of a single tube in the game. It handles the display of the bottle image and the fruit "slabs" inside it, including selection animations.

## Implementation Details
1.  **Selection Animation**: Uses an `AnimatedContainer` to lift and scale the bottle slightly when it's the `selectedIdx`.
2.  **Stack Layout**: Layers the semi-transparent bottle image and a `Column` of fruit items.
3.  **Animated Slab Transitions**: Uses `AnimatedSwitcher` with `FadeTransition` and `ScaleTransition` to animate fruits appearing or disappearing (pouring).
4.  **Dynamic Sizing**: Uses `LayoutBuilder` and `Expanded` to ensure fruits fit perfectly within the bottle's neck and body.
5.  **Mascot Scaling**: Includes a helper `_fruitScale` to adjust the size of specific fruits (like grapes or mangoes) for better visual balance.

## Code Breakdown

### 1. Selection Transform
```dart
transform: Matrix4.identity()
  ..translate(0.0, isSelected ? -40.0 : 0.0)
  ..scale(isSelected ? 1.05 : 1.0),
```
*   Translates the bottle upwards by 40 pixels and increases its size by 5% when selected.

### 2. Fruit Slab Animation
```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.2).animate(animation),
      child: child,
    ),
  );
}
```
*   Creates a "popping" effect whenever a fruit is added to or removed from the tube.
