# action_button.dart

## Overview
`action_button.dart` is a reusable UI component used for primary actions in the gameplay screen, such as "Undo", "Reset", or "Next Level".

## Implementation Details
1.  **Gradient Background**: Uses a linear gradient from the secondary container color to the secondary color for a vibrant look.
2.  **Custom Border**: Features a thick white border (`onPrimary`) to make the button stand out against complex backgrounds.
3.  **Flexible Content**: Can accept either a simple string `label` or a custom `child` widget.
4.  **Shadows**: Includes a soft shadow for depth.

## Code Breakdown

### 1. The `Container` Decoration
```dart
decoration: BoxDecoration(
  gradient: LinearGradient(colors: [colorScheme.secondaryContainer, colorScheme.secondary]),
  borderRadius: BorderRadius.circular(30),
  border: Border.all(color: colorScheme.onPrimary, width: 4),
  boxShadow: [ ... ],
)
```
*   Provides the distinctive "bubble" look with high contrast and depth.
