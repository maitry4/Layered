# dot_indicators.dart

## Overview
`dot_indicators.dart` provides a visual representation of the current page and total pages in the onboarding sequence.

## Implementation Details
1.  **Animated Transitions**: Uses `AnimatedContainer` to smoothly change the width and color of the dots.
2.  **Active State**: Highlights the current page with a wider, primary-colored dot.

## Code Breakdown

### 1. Animated Dot
```dart
AnimatedContainer(
  width: isActive ? 24 : 8,
  decoration: BoxDecoration(
    color: isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.25),
    ...
  ),
)
```
*   Simple yet effective animation that provides immediate feedback on the user's progress.
