# glossy_button.dart

## Overview
`glossy_button.dart` is a high-fidelity, custom-styled button designed for a premium user experience. It features gradients, borders, shadows, and click animations.

## Implementation Details
1.  **Stateful Interaction**: Tracks `_pressed` state to provide visual feedback.
2.  **Custom Decoration**: Combines `LinearGradient`, multiple `BoxShadow` layers, and a thick `Border` to create a "glossy" 3D effect.
3.  **Scale Animation**: Uses `AnimatedScale` to shrink the button slightly when pressed, simulating a physical click.
4.  **Text Shadows**: Uses multiple `Shadow` objects to make the text pop against the gradient background.

## Code Breakdown

### 1. Gradient & Shadows
```dart
decoration: BoxDecoration(
  gradient: LinearGradient(colors: [light, base]),
  boxShadow: [
    BoxShadow(color: dark.withOpacity(0.6), blurRadius: 8, offset: Offset(0, 4)),
    BoxShadow(color: light.withOpacity(0.4), blurRadius: 4, ...),
  ],
)
```
*   The combination of dark and light shadows creates depth and highlights.

### 2. Interaction Logic
```dart
onTapDown: (_) => setState(() => _pressed = true),
onTapUp: (_) { setState(() => _pressed = false); widget.onPressed(); },
```
*   Ensures the button reacts immediately to touch and resets correctly.
