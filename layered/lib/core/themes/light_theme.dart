import 'package:flutter/material.dart';
import 'package:layered/core/constants/app_colors.dart';
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  // ── Color scheme ─────────────────────────────────────────────────────────────
  colorScheme: const ColorScheme.light(
    primary:          AppColors.green700,
    onPrimary:        AppColors.white,
    primaryContainer: AppColors.green100,
    onPrimaryContainer: AppColors.green900,
    primaryFixed: AppColors.green500,
    
    secondary:        AppColors.orange700,
    onSecondary:      AppColors.white,
    secondaryContainer: AppColors.orange400,
    onSecondaryContainer: AppColors.orange900,

    tertiary:         AppColors.amber200,
    onTertiary:       AppColors.brown700,

    surface:          AppColors.white,
    onSurface:        AppColors.grey900,
    onSurfaceVariant: AppColors.grey500,
    surfaceContainerHighest: AppColors.grey100,
    
    outline:          AppColors.grey300,
    shadow:           AppColors.black26,

    error:            AppColors.error,
    onError:          AppColors.white,

    inverseSurface:   AppColors.blueGrey900,
  ),

  scaffoldBackgroundColor: AppColors.green50,

  // ── AppBar ───────────────────────────────────────────────────────────────────
  appBarTheme: const AppBarTheme(
    backgroundColor:  AppColors.green700,
    foregroundColor:  AppColors.white,
    elevation:        0,
    centerTitle:      true,
  ),

  // ── ElevatedButton ───────────────────────────────────────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:  AppColors.green700,
      foregroundColor:  AppColors.white,
      elevation:        0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      textStyle: const TextStyle(
        fontSize:   16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  ),

  // ── OutlinedButton ───────────────────────────────────────────────────────────
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.green700,
      side: const BorderSide(color: AppColors.green700, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      textStyle: const TextStyle(
        fontSize:   16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  ),

  // ── TextButton ───────────────────────────────────────────────────────────────
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.green700,
    ),
  ),

  // ── Typography ───────────────────────────────────────────────────────────────
  textTheme: const TextTheme(
    // Display
    displayLarge:  TextStyle(fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
    displaySmall:  TextStyle(fontSize: 36, fontWeight: FontWeight.w600),

    // Headline
    headlineLarge:  TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall:  TextStyle(fontSize: 24, fontWeight: FontWeight.w600),

    // Title
    titleLarge:  TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    titleSmall:  TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),

    // Body
    bodyLarge:   TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
    bodyMedium:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
    bodySmall:   TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.4),

    // Label
    labelLarge:  TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey700, letterSpacing: 0.5),
    labelSmall:  TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  ),


  // ── Divider ──────────────────────────────────────────────────────────────────
  dividerTheme: const DividerThemeData(
    color:     AppColors.grey300,
    thickness: 1,
    space:     1,
  ),

  // ── Card ─────────────────────────────────────────────────────────────────────
  cardTheme: CardThemeData(
    color:     AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.grey100),
    ),
  ),

  // ── Icon ─────────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(
    color: AppColors.grey700,
    size:  24,
  ),
);