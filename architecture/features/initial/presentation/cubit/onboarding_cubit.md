# onboarding_cubit.dart

## Overview
`onboarding_cubit.dart` manages the state of the onboarding process, including page transitions and the final completion step.

## Implementation Details
1.  **Page Tracking**: Maintains the current page index.
2.  **Navigation Logic**: Handles the `next()` action, transitioning between pages or completing the process.
3.  **Persistence**: Calls `HiveService` to mark onboarding as seen once completed.
4.  **Error Resilience**: Persistence failures are caught to ensure they don't block the user from entering the game.

## Code Breakdown

### 1. `next()` Method
```dart
Future<void> next() async {
  final nextPage = _currentPage + 1;
  if (nextPage < kTotalOnboardingPages) {
    emit(OnboardingPageChanged(currentPage: nextPage));
  } else {
    await _persistSeenFlag();
    emit(const OnboardingComplete());
  }
}
```
*   Increments the page index if more pages exist.
*   If the last page is reached, it marks onboarding as "seen" and emits `OnboardingComplete`.
