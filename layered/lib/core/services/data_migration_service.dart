import 'package:hive_flutter/hive_flutter.dart';

/// Service responsible for handling data schema migrations.
/// Uses a Map-based registry to adhere to the Open/Closed Principle.
class DataMigrationService {
  DataMigrationService._();
  static final DataMigrationService instance = DataMigrationService._();

  /// The latest version of the data schema.
  /// Increment this whenever you introduce breaking changes to the data structure.
  static const int currentSchemaVersion = 1; 

  /// Registry of migration tasks.
  /// Key: The version to migrate FROM.
  /// Value: The function that performs the migration to the next version.
  final Map<int, Future<void> Function()> _migrationRegistry = {
    // Example: 1: _migrateV1ToV2,
  };

  /// Main entry point for migrations.
  /// Transitions data from [fromVersion] to [currentSchemaVersion] sequentially.
  Future<void> migrate(int fromVersion) async {
    int version = fromVersion;

    while (version < currentSchemaVersion) {
      final migrationTask = _migrationRegistry[version];

      if (migrationTask != null) {
        await migrationTask();
        version++;
      } else {
        // If a version jump is missing, we stop to avoid data corruption
        break;
      }
    }
  }

  // --- Migration Tasks ---

  // Example migration task:
  // Future<void> _migrateV1ToV2() async {
  //   final progressBox = Hive.box<int>('progress');
  //   // Perform logic...
  // }
}
