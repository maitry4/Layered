# map_content.dart

## Overview
`map_content.dart` orchestrates the rendering of the scrolling game map. it combines the background image with a vertical list of level bottles positioned according to the slot constants.

## Implementation Details
1.  **Vertical PageView**: Uses a `PageView` with `scrollDirection: Axis.vertical` to create a paginated scroll effect.
2.  **Reverse Scrolling**: Set to `reverse: true` so the user scrolls "up" to progress through levels, which is a common pattern in map-based games.
3.  **Responsive Layout**: Uses `LayoutBuilder` to determine the screen dimensions and select the appropriate slot offsets.
4.  **Stacked Layers**: Layers the background image, the bottle canvas, and a floating `LevelPill` header.

## Code Breakdown

### 1. `_BottleCanvas` Page Generation
```dart
itemBuilder: (context, pageIndex) {
  return Stack(
    children: List.generate(perPage, (slotIndex) {
      final levelNumber = pageIndex * perPage + slotIndex + 1;
      final slot = slots[slotIndex];
      ...
      return Positioned(
        left: dx - bottleSize / 2,
        top: dy - (bottleSize * 1.55) / 2,
        child: LevelBottle(...),
      );
    }),
  );
}
```
*   Maps each page in the `PageView` to a cluster of levels (5 per page).
*   Calculates the exact position of each bottle based on its slot index and the current screen size.
*   Centers the bottle on the waypoint by subtracting half its width/height from the calculated coordinates.
