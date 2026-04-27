# onboarding_state.dart

## Overview
`onboarding_state.dart` defines the possible states for the onboarding flow.

## Implementation Details
1.  **Sealed Class**: Uses a `sealed class` to ensure all possible states are handled in switch statements or BlocConsumers.
2.  **Equatable**: Inherits from `Equatable` for efficient state comparison and rebuilds.

## Code Breakdown

### 1. State Classes
*   `OnboardingPageChanged`: Carries the `currentPage` index to update the UI and PageController.
*   `OnboardingComplete`: A final state indicating the user has finished onboarding.
