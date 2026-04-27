# app_colors.dart

## Overview
`app_colors.dart` is the centralized repository for all color definitions used in the application. It ensures a consistent visual language and simplifies theme management.

## Implementation Details
1.  **Abstract Class**: Defined as an `abstract final class` to prevent instantiation and inheritance.
2.  **Static Constants**: Colors are defined as `static const Color` values, grouped by their brand or functional role (Brand Green, Brand Orange, Neutrals, Semantic).
3.  **Source of Truth**: It acts as the raw data source for the application's `ThemeData`.

## Code Breakdown

### 1. Brand Colors (Green & Orange)
```dart
static const Color green900 = Color(0xFF0D3320); 
static const Color green700 = Color(0xFF237A49); // primary action
...
static const Color orange700 = Color(0xFFF57C00); // ActionButton dark
```
*   These define the core identity of the app. The comments indicate their specific primary uses.

### 2. Neutrals
```dart
static const Color grey900 = Color(0xFF1A1A1A); // primary text
static const Color white   = Color(0xFFFFFFFF);
static const Color black26 = Color(0x42000000); // shadows
```
*   Used for text, backgrounds, dividers, and shadows to provide contrast and depth.

### 3. Semantic Colors
```dart
static const Color error   = Color(0xFFD32F2F);
static const Color blueGrey900 = Color(0xFF263238); // LevelPill text
```
*   Colors assigned to specific UI components or states (like errors) to maintain functional consistency.
