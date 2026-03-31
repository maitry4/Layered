import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Slot positions — 5 stops per screen cycle following the S-curve stone path.
//
// (dx, dy) are fractions of (screenW, screenH).
// dy=0.0 → top of screen, dy=1.0 → bottom of screen (standard Flutter).
//
// Tune these pairs to align bottles with YOUR background image.
// ─────────────────────────────────────────────────────────────────────────────

/// Mobile slot positions (portrait / narrow screens).
const List<Offset> kSlotsMobile = [
  Offset(0.30, 0.69), // slot 0 — bottom-right     (lv 1, 6, 11 …)
  Offset(0.60, 0.60), // slot 1 — mid-right
  Offset(0.32, 0.40), // slot 2 — mid-right upper
  Offset(0.50, 0.33), // slot 3 — mid-left
  Offset(0.71, 0.24), // slot 4 — lower-left
];

/// Desktop slot positions (landscape / wide screens).
const List<Offset> kSlotsDesktop = [
  Offset(0.22, 0.80),
  Offset(0.45, 0.56),
  Offset(0.75, 0.60),
  Offset(0.73, 0.44),
  Offset(0.52, 0.40),
];

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Total canvas height needed to fit [total] levels across [slots] cycles.
double mapCanvasHeight(double screenH, int total, List<Offset> slots) {
  final cycles = (total / slots.length).ceil();
  return screenH * (cycles + 0.25);
}

/// Builds absolute pixel waypoints for every level on the scroll canvas.
List<Offset> buildWaypoints({
  required int total,
  required double screenW,
  required double screenH,
  required List<Offset> slots,
}) {
  return List.generate(total, (i) {
    final slot = slots[i % slots.length];
    return Offset(screenW * slot.dx, screenH * slot.dy);
  });
}