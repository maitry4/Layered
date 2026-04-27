# level_badge.dart

## Overview
`level_badge.dart` is a UI component that displays the level number inside a stylized pill/badge on top of the bottles in the map view.

## Implementation Details
1.  **Stylized Container**: Uses `BoxDecoration` with a primary color, high opacity, and a soft shadow to make the number legible.
2.  **Relative Sizing**: The padding, border radius, and font size are all derived from a single `fontSize` parameter, ensuring the badge scales proportionally with the bottle.

## Code Breakdown

### 1. The Badge Box
```dart
decoration: BoxDecoration(
  color: cs.primary.withOpacity(0.92),
  borderRadius: BorderRadius.circular(fontSize),
  boxShadow: [ ... ],
)
```
*   Creates a vibrant, slightly transparent background with a shadow to give it a "floating" appearance.
