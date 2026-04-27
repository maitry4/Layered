# app_constants.dart

## Overview
`app_constants.dart` holds global constant values that are used throughout the application to avoid "magic numbers" and ensure easy configuration.

## Implementation Details
1.  **Private Constructor**: Uses `AppConstants._()` to prevent instantiation.
2.  **Static Constants**: Values are defined as `static const` for global access without needing an instance.

## Code Breakdown

### 1. Game Configuration
```dart
static const int totalLevels = 100;
```
*   `totalLevels`: Defines the maximum number of levels available in the game, used by the level generator and map view.
