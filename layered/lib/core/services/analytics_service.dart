import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:layered/firebase_options.dart';

/// A robust, offline-safe wrapper service for Firebase Analytics.
///
/// Ensures the game never crashes or stalls even if Firebase config is missing,
/// the app is completely offline, or initialization fails.
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  FirebaseAnalytics? _analytics;
  bool _initialized = false;

  /// Returns the underlying [FirebaseAnalyticsObserver] if successfully initialized.
  FirebaseAnalyticsObserver? get observer {
    if (!_initialized || _analytics == null) return null;
    return FirebaseAnalyticsObserver(analytics: _analytics!);
  }

  /// Initializes the Firebase SDK.
  /// Runs fully offline and parses local bundled settings.
  Future<void> init() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _analytics = FirebaseAnalytics.instance;
      _initialized = true;
      debugPrint('AnalyticsService: Firebase Analytics successfully initialized.');
    } catch (e) {
      // Graceful fallback to prevent app crashes when run without configuration
      _initialized = false;
      _analytics = null;
      debugPrint('AnalyticsService warning: Failed to initialize Firebase Analytics. '
          'App will continue running without tracking. Details: $e');
    }
  }

  /// Logs when a new level is unlocked.
  /// Safe to call anywhere, does not block if offline or uninitialized.
  Future<void> logLevelUnlocked(int levelNumber) async {
    if (!_initialized || _analytics == null) {
      debugPrint('AnalyticsService: Event skipped (level_unlocked: $levelNumber) - Service not initialized.');
      return;
    }

    try {
      await _analytics!.logEvent(
        name: 'level_unlocked',
        parameters: {
          'level_number': levelNumber,
        },
      );
      debugPrint('AnalyticsService: Event logged (level_unlocked: $levelNumber).');
    } catch (e) {
      debugPrint('AnalyticsService warning: Failed to log level_unlocked event: $e');
    }
  }
}
