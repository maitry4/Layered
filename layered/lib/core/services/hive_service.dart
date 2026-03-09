import 'package:hive_flutter/hive_flutter.dart';

/// Central service for all local database operations.
///
/// All Hive boxes are opened once in [init] (called from main before runApp).
/// No other file in the codebase should import hive directly.
class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();

  // ── Box names ────────────────────────────────────────────────────────────
  static const _kOnboardingBox = 'onboarding';

  // ── Box keys ─────────────────────────────────────────────────────────────
  static const _kSeenOnboardingKey = 'has_seen_onboarding';

  // ── Internal box references ───────────────────────────────────────────────
  late final Box<bool> _onboardingBox;

  // ── Initialisation ────────────────────────────────────────────────────────

  /// Must be called once in [main] before [runApp].
  static Future<void> init() async {
    await Hive.initFlutter();
    final self = HiveService.instance;
    self._onboardingBox = await Hive.openBox<bool>(_kOnboardingBox);
  }

  // ── Onboarding ────────────────────────────────────────────────────────────

  bool get hasSeenOnboarding =>
      _onboardingBox.get(_kSeenOnboardingKey, defaultValue: false) ?? false;

  Future<void> markOnboardingSeen() =>
      _onboardingBox.put(_kSeenOnboardingKey, true);
}