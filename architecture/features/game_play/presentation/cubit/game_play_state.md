# game_play_state.dart

## Overview
`game_play_state.dart` defines the states of the gameplay screen.

## Implementation Details
1.  **Sealed Class**: For exhaustive state management.
2.  **`GamePlayLoaded`**: The most important state, carrying the current board (`level`), the `selectedTubeIndex`, and the move `history`.
3.  **`copyWith`**: Includes a `clearSelection` flag to easily reset the selection without explicitly passing `null`.

## Code Breakdown

### 1. `GamePlayLoaded` with Undo History
```dart
final class GamePlayLoaded extends GamePlayState {
  final UILevel level;
  final int? selectedTubeIndex;
  final List<List<Tube>> history; 
  ...
}
```
*   The `history` field is a stack of previous tube arrangements, enabling the undo feature.
