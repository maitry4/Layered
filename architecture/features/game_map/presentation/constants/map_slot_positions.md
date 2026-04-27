# map_slot_positions.dart

## Overview
`map_slot_positions.dart` defines the spatial layout of the levels on the game map. It ensures that levels are positioned along a specific "S-curve" path that matches the background artwork.

## Implementation Details
1.  **Offset Fractions**: Positions are defined as `Offset` fractions (0.0 to 1.0) rather than absolute pixels, making them responsive to any screen size.
2.  **Device-Specific Layouts**: Provides separate slot configurations for `kSlotsMobile` and `kSlotsDesktop` to account for different aspect ratios.
3.  **Canvas Calculations**: Includes helper functions to calculate the total canvas height and absolute pixel waypoints.

## Code Breakdown

### 1. Mobile Slots
```dart
const List<Offset> kSlotsMobile = [
  Offset(0.24, 0.69), 
  Offset(0.60, 0.60), 
  ...
];
```
*   These fractions represent the X and Y coordinates relative to the screen size where bottles should be placed.

### 2. `buildWaypoints` Function
```dart
List<Offset> buildWaypoints({ ... }) {
  return List.generate(total, (i) {
    final slot = slots[i % slots.length];
    return Offset(screenW * slot.dx, screenH * slot.dy);
  });
}
```
*   Converts the fractional offsets into actual pixel coordinates based on the current `screenW` and `screenH`.
