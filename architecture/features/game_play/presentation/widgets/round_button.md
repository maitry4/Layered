# round_button.dart

## Overview
`round_button.dart` is a specialized button used for secondary actions like "Back".

## Implementation Details
1.  **Circular Shape**: Uses `BoxShape.circle` for a classic icon-button look.
2.  **Color Identity**: Uses the `tertiary` color from the theme, providing a visual distinction from primary action buttons.
3.  **Border Contrast**: Like the `ActionButton`, it uses a thick white border to ensure visibility.

## Code Breakdown

### 1. Shape & Border
```dart
decoration: BoxDecoration(
  color: colorScheme.tertiary,
  shape: BoxShape.circle,
  border: Border.all(color: colorScheme.onPrimary, width: 3),
)
```
*   Creates a high-contrast circular button that stands out on any background.
