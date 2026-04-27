# error_page.dart

## Overview
`error_page.dart` is a fallback screen displayed whenever a navigation error occurs or an unhandled exception is caught by the router.

## Implementation Details
1.  **Error Parsing**: Analyzes the exception to provide a user-friendly message.
2.  **Technical Details**: Displays the raw error string in a selectable format for debugging.
3.  **Recovery Path**: Provides a "Go to Home" button to return the user to a safe state (`splash`).

## Code Breakdown

### 1. The `_parseError` Helper
```dart
String _parseError(Exception? error) {
  if (error == null) return 'An unknown error occurred.';
  final errorString = error.toString();
  if (errorString.contains('No routes for location')) {
    return 'The page you\'re looking for doesn\'t exist.';
  }
  ...
}
```
*   Maps complex technical exceptions to simple, human-readable strings based on keywords like "No routes", "network", or "permission".

### 2. UI Structure
```dart
return Scaffold(
  body: Column(
    children: [
      Text('Oops! An error occurred.'),
      Text(message, style: TextStyle(color: Colors.red)),
      if (error != null) SelectableText(error.toString()),
      ElevatedButton(onPressed: () => context.goNamed(AppRoutes.splash), ...),
    ],
  ),
);
```
*   Uses a simple vertical layout to present the error message, technical details (if any), and a recovery button.
