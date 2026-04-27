# game_play_cubit.dart

## Overview
`game_play_cubit.dart` is the primary business logic controller for the gameplay. it manages level loading, user interactions (tapping tubes), pouring logic, undo functionality, and win conditions.

## Implementation Details
1.  **Level Generation**: Delegates the creation of a new board to `LevelGenerator`.
2.  **Interaction State**: Tracks which tube is currently selected by the user.
3.  **Pouring Orchestration**: When two tubes are tapped in sequence, it validates and executes the pour.
4.  **Undo System**: Maintains a `history` of tube states (`List<List<Tube>>`) to allow players to backtrack. The history is limited to the **last 30 moves** to optimize memory usage.
5.  **Win Condition**: Checks if all tubes are "sorted" (either empty or full and uniform) after every move.
6.  **Progress Updates**: Calls `HiveService` to unlock the next level upon victory.

## Code Breakdown

### 1. `onTubeTapped` logic
```dart
void onTubeTapped(int index) {
  ...
  if (selectedIdx == null) {
    if (!currentState.level.tubes[index].isEmpty) {
      emit(currentState.copyWith(selectedTubeIndex: index));
    }
  } else if (selectedIdx == index) {
    emit(currentState.copyWith(clearSelection: true));
  } else {
    _handlePour(currentState, selectedIdx, index);
  }
}
```
*   First tap: Selects a non-empty tube.
*   Second tap (same tube): Deselects.
*   Second tap (different tube): Attempts a pour.

### 2. `_handlePour` Logic
```dart
while (tempSource.top == fruitToMove && tempTarget.canReceive(fruitToMove)) {
  tempTarget = tempTarget.add(tempSource.top!);
  tempSource = tempSource.pop();
}
```
*   Implements "batch pouring": if there are multiple consecutive fruits of the same type at the top of the source, and there is enough room in the target, it moves all of them in one go.
