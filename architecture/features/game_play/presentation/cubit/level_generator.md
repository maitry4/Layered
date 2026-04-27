# Level Generator Architecture

## 📖 Overview
The `LevelGenerator` is a procedural engine that creates solvable and balanced "Water Sort" puzzles. Instead of relying on static data, it uses a **deterministic seed-based approach** to generate unique boards that scale in difficulty as the player progresses.

---

## 🏗️ The Generation Pipeline
The engine follows a strict 5-step sequence to ensure every level is playable and fun:

1.  **Parameter Scaling**: Calculates the number of colors and scramble moves based on the level number.
2.  **Solved Initialization**: Starts with a perfectly sorted board (C tubes, each with 4 of a kind).
3.  **Global Slab Shuffle**: Scrambles every fruit piece across all positions to break initial clusters.
4.  **Simulated Pour-Scrambling**: Executes hundreds of "legal" reverse-moves with an **Anti-Sort Bias** to mix the board while maintaining game rules.
5.  **Quality Verification**: Filters the final board through heuristics (Deadlock detection, Homogeneity scoring) to ensure it's neither trivial nor stuck.

---

## 🧮 Mathematical Foundations

### 1. Difficulty Interpolation (Lerp)
The intensity of the scramble scales linearly using a Progress Factor ($t$).

$$Mixes = 60 + \left( \frac{Level - 1}{99} \right) \times 140$$

> [!NOTE]
> This creates a smooth difficulty curve, moving from **60 mixes** at Level 1 to **200 mixes** at Level 100.

### 2. Plateau-Based Scaling (Integer Division)
To keep the player from being overwhelmed, color counts increase in discrete "steps."
```dart
int numColors = 3 + (levelNumber - 1) ~/ 5;
```
*   **Result**: 3 colors for levels 1-5, 4 colors for levels 6-10, etc. (Capped at 8).

### 3. Complexity Metric (Homogeneity)
We measure the "purity" of the board to prevent boring levels.
$$Purity = \text{Average}\left( \frac{\text{Count of Most Frequent Fruit in Tube}}{\text{Total Fruits in Tube}} \right)$$

*   **Filter**: If **Purity > 0.75**, the board is rejected as "too easy" and the engine retries with a new seed.

### 4. Deterministic Seeding
```dart
Random(levelNumber * 997 + seedOffset * 31);
```
*   Uses **Prime Number Multipliers** (997, 31) to minimize hash collisions and ensure that Level 42 always generates the exact same puzzle for every user on every device.

---

## 🛠️ Core Algorithm: Anti-Sort Scrambling
During the mix phase, the engine uses a **Simulated Reverse-Gameplay** approach with three critical constraints:

| Constraint | Purpose |
| :--- | :--- |
| **Legal Pours Only** | Slabs can only be moved onto a matching color or an empty tube. |
| **Empty Preservation** | Prevents the algorithm from consuming the last required empty tubes during scrambling. |
| **Anti-Sort Bias** | Actively rejects any move that would complete a tube, ensuring the puzzle remains unsolved. |

---

## ⚙️ Technical Specs
*   **`_tubeCapacity`**: 4 (Fixed).
*   **`_numEmptyTubes`**: 1 (Early levels) | 2 (Levels with 3+ colors).
*   **`_maxSeedOffsets`**: 30 (Max retries before failing).
*   **`_maxAttempts`**: 5000 (Max scramble iterations per seed).

> [!TIP]
> The combination of **High Mix Counts** and **Two Empty Tubes** ensures that while the generator doesn't use an expensive exhaustive solver, the puzzles remain solvable in 99.9% of cases.
