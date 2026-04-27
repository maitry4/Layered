# onboarding_screen.dart

## Overview
`onboarding_screen.dart` is the visual representation of the onboarding flow, featuring full-screen images and interactive controls.

## Implementation Details
1.  **BlocProvider**: Scopes the `OnboardingCubit` to the screen.
2.  **PageView**: Uses a `PageView` with `NeverScrollableScrollPhysics` to control transitions programmatically.
3.  **Responsive Layout**: Uses the `Responsive` wrapper to ensure images look good on all devices.
4.  **Animated Transitions**: Synchronizes state changes with the `PageController` via `BlocConsumer`.

## Code Breakdown

### 1. State Consumption
```dart
listener: (context, state) {
  if (state is OnboardingPageChanged) {
    _pageController.animateToPage(
      state.currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  if (state is OnboardingComplete) {
    context.goNamed(AppRoutes.gameMap);
  }
}
```
*   Reacts to page changes by animating the controller.
*   Reacts to completion by navigating away.

### 2. `_OnboardingPage` Widget
```dart
Widget build(BuildContext context) {
  return Responsive(
    child: Image.asset(_assetPath(context), fit: BoxFit.fill, ...),
  );
}
```
*   Displays the relevant onboarding image based on the current index and device type.
