// lib/core/level_generator.dart

import 'dart:math';

import 'package:layered/features/game_play/domain/fruit_type.dart';
import 'package:layered/features/game_play/domain/tube.dart';
import 'package:layered/features/game_play/domain/ui_level.dart';


class LevelGenerator {
  static const int _tubeCapacity = 4;
  static const int _maxSeedOffsets = 10;
  static const int _maxAttempts = 1200;

  // ---------------------------------------------------------------------------
  // Number of empty (buffer) tubes scales with color count so that the
  // scrambler always has enough breathing room to complete its target mixes.
  //
  //   ≤ 4 colors  →  2 empty tubes  (5–6  total)
  //   5–6 colors  →  3 empty tubes  (8–9  total)
  //   7–8 colors  →  4 empty tubes  (11–12 total)
  //
  // Previously this was a hard-coded constant of 2, which caused the scrambler
  // to deadlock on levels 11+ where more colors fill tubes much faster, leaving
  // zero valid moves on the generated board.
  // ---------------------------------------------------------------------------
  static int _numEmptyTubes(int numColors) {
    if (numColors <= 4) return 2;
    if (numColors <= 6) return 3;
    return 4;
  }

  // ---------------------------------------------------------------------------
  // Difficulty scaling
  //
  //  numColors : starts at 3, +1 every 10 levels, capped at 8
  //  numMixes  : starts at 12, scales to 67 by level 100
  // ---------------------------------------------------------------------------
  static ({int numColors, int numMixes}) _getParams(int levelNumber) {
    int numColors = 3 + (levelNumber - 1) ~/ 10;
    if (numColors > 8) numColors = 8;

    final double scrambleFactor =
        ((levelNumber - 1) / 99.0).clamp(0.0, 1.0);
    final int numMixes = (12 + scrambleFactor * 55).toInt();

    return (numColors: numColors, numMixes: numMixes);
  }

  static bool _isAlreadySolved(List<Tube> tubes) {
    final nonEmpty = tubes.where((t) => !t.isEmpty).toList();
    if (nonEmpty.isEmpty) return true;
    return nonEmpty.every((t) => t.isComplete);
  }

  // Returns true when no legal pour exists — a deadlocked board is unplayable
  // even though it is not technically "solved".
  static bool _isDeadlocked(List<List<FruitType>> tubes, int capacity) {
    final n = tubes.length;
    for (int si = 0; si < n; si++) {
      final src = tubes[si];
      if (src.isEmpty) continue;
      final color = src.last;
      for (int ti = 0; ti < n; ti++) {
        if (si == ti) continue;
        final tgt = tubes[ti];
        if (tgt.length >= capacity) continue;
        if (tgt.isNotEmpty && tgt.last != color) continue;
        return false; // at least one valid move exists
      }
    }
    return true;
  }

  // ---------------------------------------------------------------------------
  // Main entry point
  // ---------------------------------------------------------------------------
  static UILevel generate(int levelNumber) {
    final params = _getParams(levelNumber);
    final int C = params.numColors;
    final int K = _tubeCapacity;
    final int E = _numEmptyTubes(C);
    final int N = C + E;

    for (int seedOffset = 0; seedOffset < _maxSeedOffsets; seedOffset++) {
      final random = Random(levelNumber * 1000 + seedOffset);

      // 1. Create K slabs of each color and shuffle
      final List<FruitType> slabs = [];
      for (int i = 0; i < C; i++) {
        for (int j = 0; j < K; j++) {
          slabs.add(FruitType.values[i]);
        }
      }
      _shuffle(slabs, random);

      // 2. Distribute shuffled slabs into C filled tubes + E empty tubes
      List<List<FruitType>> tubes = [];
      int idx = 0;
      for (int i = 0; i < C; i++) {
        tubes.add(List<FruitType>.from(slabs.sublist(idx, idx + K)));
        idx += K;
      }
      for (int i = 0; i < E; i++) {
        tubes.add([]);
      }

      // 3. Scramble via valid pours
      //    The extra empty tubes keep the move space open long enough for the
      //    scrambler to reach its full numMixes target even at 8 colors.
      int successful = 0;
      int attempts = 0;
      while (successful < params.numMixes && attempts < _maxAttempts) {
        attempts++;
        final srcI = random.nextInt(N);
        final tgtI = random.nextInt(N);
        if (srcI == tgtI) continue;

        final src = tubes[srcI];
        final tgt = tubes[tgtI];
        if (src.isEmpty || tgt.length >= K) continue;

        final color = src.last;
        if (tgt.isNotEmpty && tgt.last != color) continue;

        // Count the contiguous top-block of this color
        int blockSize = 1;
        for (int i = src.length - 2; i >= 0; i--) {
          if (src[i] == color) {
            blockSize++;
          } else {
            break;
          }
        }

        final pourAmt =
            blockSize < (K - tgt.length) ? blockSize : (K - tgt.length);
        for (int p = 0; p < pourAmt; p++) {
          tgt.add(src.removeLast());
        }
        successful++;
      }

      // 4. Randomise display order
      _shuffleTubes(tubes, random);

      // Convert to immutable Tube objects
      final tubeObjects = tubes
          .map((t) => Tube(capacity: K, slabs: List<FruitType>.from(t)))
          .toList();

      // Skip if accidentally solved
      if (_isAlreadySolved(tubeObjects)) continue;

      // Skip if deadlocked (no legal move exists) — previously undetected
      if (_isDeadlocked(tubes, K)) continue;

      return UILevel(
        levelNumber: levelNumber,
        tubes: tubeObjects,
        numColors: C,
      );
    }

    // Should never be reached with the scaled empty-tube count
    throw StateError(
      'Could not generate a valid unsolved puzzle for level $levelNumber',
    );
  }

  // Fisher-Yates shuffle for List<FruitType>
  static void _shuffle(List<FruitType> list, Random random) {
    for (int i = list.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
  }

  // Fisher-Yates shuffle for List<List<FruitType>>
  static void _shuffleTubes(List<List<FruitType>> list, Random random) {
    for (int i = list.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
  }
}