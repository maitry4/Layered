# bottom_controls.dart

## Overview
`bottom_controls.dart` houses the navigation elements at the bottom of the onboarding screen, including indicators and the primary action button.

## Implementation Details
1.  **Dynamic Label**: Changes the button text from "Next" to "Get Started" on the final page.
2.  **Cubit Interaction**: Triggers the `next()` action in `OnboardingCubit`.

## Code Breakdown

### 1. Composition
```dart
children: [
  DotIndicators(currentPage: currentPage, ...),
  SizedBox(height: 28),
  GlossyButton(label: label, onPressed: () => context.read<OnboardingCubit>().next()),
]
```
*   Combines the pagination dots and the action button with consistent spacing.
