# level_generator.dart

## Overview
`level_generator.dart` is the procedural engine responsible for creating solvable, balanced, and increasingly difficult "Water Sort" puzzles. Unlike static level files, this engine uses a deterministic seed-based approach to generate thousands of unique boards on the fly.

## 🏗️ The Generation Pipeline

The generator follows a strict 5-step pipeline to ensure quality and solvability:

### 1. Difficulty Scaling (`_getParams`)
The engine calculates level parameters based on the `levelNumber`.
*   **Colors**: Starts at 3. Adds 1 color every 5 levels, capping at 8.
*   **Mixes**: Scramble intensity increases linearly from 60 mixes (Level 1) to 200 mixes (Level 100).
*   **Empty Tubes**: Dynamically assigned (1 if colors < 3, 2 if colors >= 3) to provide enough "breathing room" for complex puzzles.

### 2. Base State Creation
The generator begins with a **perfectly solved board**. It creates $C$ tubes, each filled with 4 slabs of a unique color. This guarantees that the total inventory of fruits is always balanced (exactly 4 of each color).

### 3. Deep Slab Shuffle
Before any "pouring" starts, the generator shuffles every individual slab across all available positions. This breaks the initial "solved" clusters and creates a chaotic starting point for the scrambling algorithm.

### 4. Anti-Sort Scrambling (The Core Algorithm)
This is a reverse-simulation of gameplay. The engine performs hundreds of random "legal" moves with a specific **Anti-Sort Bias**:
*   **Legal Pours only**: Slabs can only be "poured" onto a matching color or into an empty tube.
*   **Empty Tube Preservation**: The algorithm ensures it never fills the last required empty tube during the scramble, ensuring the user always starts with a valid workspace.
*   **Anti-Sort Check**: It rejects any move that would accidentally result in a "Complete" tube (4 of a kind). This prevents the generator from solving the puzzle for the user during the mix phase.

### 5. Post-Generation Verification (Heuristics)
To prevent bad user experiences, every generated board is passed through three filters:
1.  **Solved Check**: Rejects boards that are accidentally already solved.
2.  **Deadlock Check**: Analyzes the top fruits of all tubes. If no legal move exists from the very first frame, the board is discarded.
3.  **Homogeneity Score**: A mathematical metric (0.0 to 1.0) that measures how "clumped" colors are. If the score is > 0.75 (meaning the board is too sorted/easy), the engine throws it away and retries with a new seed.

## 🛠️ Code Breakdown

### 1. Difficulty Math
```dart
int numColors = 3 + (levelNumber - 1) ~/ 5; // +1 color every 5 levels
final double t = ((levelNumber - 1) / 99.0).clamp(0.0, 1.0);
final int numMixes = (60 + t * 140).toInt(); // Linear scale 60 -> 200
```

### 2. The Deadlock Heuristic
```dart
static bool _isDeadlocked(List<List<FruitType>> tubes, int capacity) {
  for (int si = 0; si < n; si++) {
    final color = src.last;
    for (int ti = 0; ti < n; ti++) {
      if (tgt.length < capacity && (tgt.isEmpty || tgt.last == color)) {
        return false; // Found at least one legal move
      }
    }
  }
  return true; // No legal moves possible
}
```
*   This function ensures the player is never presented with a "stuck" board at the start of a level.

### 3. The Homogeneity Metric
```dart
static double _homogeneity(List<List<FruitType>> tubes) {
  // Calculates the average "purity" of all tubes.
  // We want a low score for a well-scrambled, difficult puzzle.
}
```

## ⚙️ Technical Constraints
*   **`_tubeCapacity`**: Hardcoded to 4 (standard for this genre).
*   **`_maxSeedOffsets`**: 30 (The engine will try up to 30 different random seeds to find a "valid" hard board before giving up).
*   **`_maxAttempts`**: 5000 (Maximum scramble attempts per seed).

# level_generator.dart - Mathematical Deep Dive

## 🧮 Mathematical Foundations

The Level Generator relies on several mathematical concepts to ensure that puzzles are not just "random," but are statistically balanced and logically sound.

### 1. Linear Difficulty Scaling (Interpolation)
The number of "mix moves" (how many times the generator pours slabs during scrambling) is calculated using a **Linear Interpolation (Lerp)** formula.

$$Mixes = StartValue + (EndValue - StartValue) \times t$$

In the code:
```dart
final double t = ((levelNumber - 1) / 99.0).clamp(0.0, 1.0);
final int numMixes = (60 + t * 140).toInt();
```
*   **$t$ (The Progress Factor)**: Normalizes the current level (1-100) into a value between `0.0` and `1.0`.
*   **Scaling**: At Level 1 ($t=0$), mixes = 60. At Level 100 ($t=1$), mixes = 200 ($60 + 140$). This ensures a smooth, predictable increase in complexity.

### 2. Discrete Step Scaling (Integer Division)
The number of colors increases at specific "milestones" rather than every level. This uses **Integer Division**.

```dart
int numColors = 3 + (levelNumber - 1) ~/ 5;
```
*   The `~/` operator performs a division and truncates the remainder.
*   **Logic**: Level 1-5 = 3 colors, Level 6-10 = 4 colors, etc. This creates "difficulty plateaus," allowing the player to master a specific number of colors before the game introduces more complexity.

### 3. Complexity Heuristics: Homogeneity Score
To ensure a level isn't "boring" (e.g., half the bottles are already sorted), we calculate a **Purity Ratio** for each tube.

$$Purity = \frac{\text{Count of Most Frequent Fruit}}{\text{Total Fruits in Tube}}$$

**The Calculation**:
1.  For every tube, we find the "Max Frequency" of a single color.
2.  If a tube has `[Apple, Apple, Lime, Apple]`, the ratio is $3/4 = 0.75$.
3.  We average these ratios across all tubes.
4.  **Threshold**: If the average is $> 0.75$, the board is rejected. This mathematically guarantees that colors are "spread out" enough to require strategic thinking.

### 4. Deterministic Randomness (Seed Logic)
To ensure a specific level number always generates the same puzzle for every player, we use a calculated **Random Seed**.

```dart
final random = Random(levelNumber * 997 + seedOffset * 31);
```
*   **997 & 31**: These are **Prime Numbers**. 
*   Using large primes for seeding minimizes "collisions" (where two different levels accidentally look the same) and ensures a high degree of entropy (perceived randomness) in the resulting boards.

### 5. Probability and Retries
Because the generator uses "Anti-Sort Bias" and "Empty Tube Preservation," it is possible for a scramble to fail or produce an "easy" board.
*   **`_maxSeedOffsets = 30`**: This gives the engine a **$30 \times$ retry buffer**. 
*   If the math results in a board that is too simple (Homogeneity > 0.75) or deadlocked, it shifts the seed and tries again. This "Generate-and-Test" pattern ensures that even though the process is random, the **output is always high quality**.

### 6. Cycle-Based Positioning (Modulo Math)
In the map view, levels are positioned using **Modulo Arithmetic** to loop through a set of slot offsets.

```dart
final slot = slots[i % slots.length];
```
*   This ensures that no matter how many levels we have (e.g., 100), the positions always cycle through the 5 predefined "S-Curve" points (`kSlotsMobile`), creating a continuous path.
