# level_pill.dart

## Overview
`level_pill.dart` is a header component that displays the current level number in a clean, semi-transparent container.

## Implementation Details
1.  **High Readability**: Uses a high-contrast color (`inverseSurface`) against a semi-transparent white background (`surface`).
2.  **Soft Edges**: Features a large border radius (30) for a modern, friendly look.

## Code Breakdown

### 1. Container Styling
```dart
decoration: BoxDecoration(
  color: colorScheme.surface.withOpacity(0.9),
  borderRadius: BorderRadius.circular(30),
)
```
*   Ensures the pill is visible even over busy backgrounds while maintaining a "glassy" aesthetic.
