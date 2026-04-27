# light_theme.dart

## Overview
`light_theme.dart` defines the visual identity of the application. It configures the colors, typography, and component styles (buttons, cards, etc.) for the light mode.

## Implementation Details
1.  **Material 3**: Uses `useMaterial3: true` for modern UI components.
2.  **ColorScheme**: Maps raw colors from `AppColors` to semantic roles like `primary`, `secondary`, and `surface`.
3.  **Sub-Themes**: Customizes specific widgets like `AppBar`, `ElevatedButton`, and `Card` to match the "Layered" design language.
4.  **Typography**: Sets up a comprehensive `TextTheme` with consistent font sizes and weights.

## Code Breakdown

### 1. Color Scheme Mapping
```dart
colorScheme: const ColorScheme.light(
  primary: AppColors.green700,
  secondary: AppColors.orange700,
  surface: AppColors.white,
  ...
),
```
*   Links the brand colors to functional roles used by standard Flutter widgets.

### 2. Button Styling
```dart
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor:  AppColors.green700,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ...
  ),
),
```
*   Defines a consistent look for all `ElevatedButton`s, ensuring they have the primary green color and rounded corners.

### 3. Typography
```dart
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w700),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
  ...
),
```
*   Establishes the font scale for the entire app, providing presets for headings, body text, and labels.
