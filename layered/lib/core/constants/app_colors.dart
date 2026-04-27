import 'package:flutter/material.dart';

/// Single source of truth for all raw color values.
/// Never reference these directly in widgets — always go through [ThemeData]
/// or [ColorScheme] so dark mode works for free when you add it.
abstract final class AppColors {
  // ── Brand: Green ────────────────────────────────────────────────────────────
  static const Color green900 = Color(0xFF0D3320); 
  static const Color green700 = Color(0xFF237A49); // primary action
  static const Color green500 = Color(0xFF3DBE74); 
  static const Color green100 = Color(0xFFDDF5E8);
  static const Color green50  = Color(0xFFF2FBF5); // scaffold background

  // ── Brand: Orange ───────────────────────────────────────────────────────────
  static const Color orange900 = Color(0xFF4D1C00);
  static const Color orange700 = Color(0xFFF57C00); // ActionButton dark
  static const Color orange400 = Color(0xFFFFB74D); // ActionButton light

  // ── Brand: Amber/Yellow ──────────────────────────────────────────────────────

  static const Color amber200 = Color(0xFFFFE082); // RoundButton

  // ── Neutrals ────────────────────────────────────────────────────────────────
  static const Color grey900 = Color(0xFF1A1A1A); // primary text
  static const Color grey700 = Color(0xFF3D3D3D);
  static const Color grey500 = Color(0xFF737373); // secondary text
  static const Color grey300 = Color(0xFFB8B8B8); // dividers
  static const Color grey100 = Color(0xFFF0F0F0); // card backgrounds
  static const Color white   = Color(0xFFFFFFFF);
  static const Color black26 = Color(0x42000000); // shadows

  // ── Semantic ─────────────────────────────────────────────────────────────────
  static const Color blueGrey900 = Color(0xFF263238); // LevelPill text
  static const Color brown700 = Color(0xFF5D4037); // RoundButton icon
  static const Color error   = Color(0xFFD32F2F);
}
