# game_play_board.dart

## Overview
`game_play_board.dart` is the layout manager for the gameplay screen. It organizes the header, the grid of bottles, and the footer action buttons.

## Implementation Details
1.  **Responsive Grid**: Uses a `GridView.builder` to display the bottles. The `crossAxisCount` and `mainAxisExtent` adapt to the screen size (mobile vs. desktop).
2.  **Safe Area**: Wraps the content in a `SafeArea` to avoid overlapping with notches or system bars.
3.  **Header & Footer**: Provides consistent padding and spacing for navigation and control elements.
4.  **Interactive Bottles**: Wraps each `BottleWidget` in a `GestureDetector` that notifies the `GamePlayCubit` when a tube is tapped.

## Code Breakdown

### 1. Responsive Grid Calculation
```dart
final isMobile = Responsive.isMobile(context);
final crossAxisCount = isMobile ? 5 : level.tubes.length;
...
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: crossAxisCount,
  mainAxisExtent: isMobile ? 190 : 350,
  ...
),
```
*   Dynamically changes the grid density. On mobile, it limits to 5 columns per row. On desktop, it tries to show all tubes in one row for better visibility.
