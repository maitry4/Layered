# main.dart

## Overview
The `main.dart` file serves as the entry point for the "Layered" application. It is responsible for initializing the core services, configuring the application environment, and bootstrapping the root widget.

## Implementation Details
1.  **Initialization**: It ensures that Flutter bindings are initialized before any asynchronous operations.
2.  **URL Strategy**: It sets the web URL strategy to use paths instead of hashes (relevant for Flutter Web).
3.  **Local Storage**: It initializes `HiveService` for persistent data storage.
4.  **Root Widget**: It launches the `LayeredApp` widget, which sets up the global theme, routing, and top-level state management using Bloc.

## Code Breakdown

### 1. The `main` Function
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await HiveService.init();
  runApp(const LayeredApp());
}
```
*   `WidgetsFlutterBinding.ensureInitialized()`: Ensures that the Flutter engine is ready to interact with the platform before calling any plugins.
*   `usePathUrlStrategy()`: Removes the `#` from URLs when running on the web, making them cleaner.
*   `HiveService.init()`: Prepares the Hive database for use across the application.
*   `runApp(const LayeredApp())`: Attaches the main application widget to the screen.

### 2. The `LayeredApp` Widget
```dart
class LayeredApp extends StatelessWidget {
  const LayeredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Layered',
        routerConfig: appRouter,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```
*   `MultiBlocProvider`: Injects global BLoCs that need to be available throughout the app's lifecycle. Here, `SplashCubit` is initialized.
*   `MaterialApp.router`: Configures the app to use the specialized router system (`appRouter`) for navigation.
*   `routerConfig: appRouter`: Connects the pre-defined GoRouter configuration.
*   `theme: lightTheme`: Applies the global light theme defined in the `core/themes` directory.
