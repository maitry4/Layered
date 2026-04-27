# fruit_assets.dart

## Overview
`fruit_assets.dart` is a utility file that maps `FruitType` enum values to their corresponding file paths in the assets folder.

## Implementation Details
1.  **Switch Expression**: Uses Dart's modern switch expression to provide a clean, exhaustive mapping.

## Code Breakdown

### 1. `fruitAsset` Function
```dart
String fruitAsset(FruitType type) {
  return switch (type) {
    FruitType.apple => 'assets/fruits/apple.webp',
    ...
  };
}
```
*   Centralizes asset path management, making it easy to update or add new fruits.
