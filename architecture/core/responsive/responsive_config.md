# responsive_config.dart

## Overview
`responsive_config.dart` provides utilities for building a responsive user interface that adapts to different screen sizes (Mobile, Tablet, Desktop).

## Implementation Details
1.  **AppBreakpoints**: Defines standard width thresholds for different device categories.
2.  **Responsive Widget**: A wrapper widget that constrains the content width on larger screens to maintain readability.
3.  **Static Helper Methods**: Provides quick boolean checks (`isMobile`, `isTablet`, `isDesktop`) using `MediaQuery`.

## Code Breakdown

### 1. Breakpoints
```dart
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
  static const double maxContentWidth = 1920;
}
```
*   These values determine when the layout should shift from one mode to another.

### 2. Static Checkers
```dart
static bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width < AppBreakpoints.mobile;
```
*   These methods allow developers to conditionally render widgets or styles based on the current screen width.

### 3. The `Responsive` Widget
```dart
@override
Widget build(BuildContext context) {
  final effectiveMaxWidth = maxWidth ?? AppBreakpoints.maxContentWidth;
  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
      child: child,
    ),
  );
}
```
*   Ensures that on very wide screens (like 4K monitors), the application content doesn't stretch excessively, keeping it centered and constrained.
