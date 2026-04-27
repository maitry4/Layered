# level_generator.dart

## Overview
`level_generator.dart` is a sophisticated engine that procedurally generates solvable "Water Sort" puzzles. It scales difficulty based on the level number.

## Implementation Details
1.  **Difficulty Scaling**: Adjusts the number of colors (3 to 8) and the number of scramble mixes based on progress.
2.  **Procedural Generation**: 
    *   Starts with a "solved" state (full tubes of uniform colors).
    *   Shuffles all individual "slabs" (fruit pieces).
    *   Distributes them into tubes.
    *   Performs a series of "pour scrambles" (simulated reverse moves) to mix them up while ensuring the game rules are respected.
3.  **Solvability Checks**: Validates that the generated board is not already solved, not deadlocked, and meets a "homogeneity" threshold (ensures it's sufficiently mixed).
4.  **Empty Tubes**: Dynamically calculates the number of empty tubes needed to keep the puzzle solvable as complexity increases.

## Code Breakdown

### 1. Pour Scramble with Anti-Sort Bias
```dart
while (successful < params.numMixes && ...) {
  ...
  // Anti-sort: reject if this would complete a tube
  if (tgt.length == K - 1 && tgt.isNotEmpty && tgt.every((s) => s == color)) {
    continue; 
  }
  tgt.add(src.removeLast());
}
```
*   The generator actively avoids moves that would simplify the puzzle during the scrambling phase.

### 2. Solvability Verification
```dart
if (_isDeadlocked(tubes, K)) continue;
final h = _homogeneity(tubes);
if (h > 0.75) continue;
```
*   Uses a retry-loop with different random seeds to find a board that is both solvable and adequately difficult.
