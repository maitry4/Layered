# game_play_screen.dart

## Overview
`game_play_screen.dart` is the main container for the gameplay experience. It manages the background, the game board, victory dialogs, and confetti effects.

## Implementation Details
1.  **BlocProvider**: Scopes the `GamePlayCubit` to the screen.
2.  **Confetti Integration**: Uses the `confetti` package to celebrate a win.
3.  **Victory Dialog**: A high-fidelity modal that appears when the user completes a level.
4.  **Entrance Animation**: Similar to the map, it uses a scale-in effect when first loaded.
5.  **Responsive Background**: Switches between mobile and desktop-optimized background assets.

## Code Breakdown

### 1. Victory Listener
```dart
listener: (context, state) {
  if (state is GamePlayVictory) {
    _showVictoryDialog(context, state.levelNumber);
  }
}
```
*   Triggers the celebration sequence when the cubit emits a victory state.

### 2. Victory Dialog Composition
```dart
showDialog(
  builder: (dContext) => Stack(
    children: [
      ConfettiWidget(...),
      Container( // Main Card
        child: Column(
          children: [
            Text("Level Complete!"),
            ActionButton(label: "Next Level", ...),
          ],
        ),
      ),
      Positioned(child: Image.asset('win_orange.webp')), // Floating mascot
    ],
  ),
);
```
*   Uses a `Stack` to layer confetti, the message card, and a mascot image for a premium look.
