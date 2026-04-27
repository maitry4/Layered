# bottle_data.dart

## Overview
`bottle_data.dart` is a simple data class used to represent the content of a bottle in a serializable or static format.

## Implementation Details
1.  **Pure Data**: Contains no business logic.
2.  **Fruit List**: Stores fruit names as a list of strings, ordered from bottom to top.

## Code Breakdown

### 1. `BottleData` Class
```dart
class BottleData {
  final List<String> fruits; 
  const BottleData({required this.fruits});
}
```
*   Provides a structured way to pass around the contents of a single container.
