# tube.dart

## Overview
`tube.dart` contains the core gameplay logic for a single container (bottle). It handles validation rules for pouring and maintains the stack of fruits.

## Implementation Details
1.  **Immutability**: Designed to be immutable. Methods like `add` and `pop` return a new `Tube` instance.
2.  **Capacity**: Enforces a maximum number of items.
3.  **Validation**: Implements the "Water Sort" rules:
    *   Cannot pour into a full tube.
    *   Can pour any fruit into an empty tube.
    *   Can only pour onto a matching fruit type.
4.  **Completion Logic**: A tube is considered "complete" if it is full and all fruits inside are of the same type.

## Code Breakdown

### 1. Rule Validation
```dart
bool canReceive(FruitType fruit) {
  if (isFull) return false;
  if (isEmpty) return true;
  return top == fruit;
}
```
*   This is the heart of the game logic, preventing illegal moves.

### 2. State Transformation
```dart
Tube add(FruitType fruit) {
  final newSlabs = List<FruitType>.from(slabs)..add(fruit);
  return Tube(capacity: capacity, slabs: newSlabs);
}
```
*   Returns a new version of the tube with the added fruit, maintaining the immutable architecture.
