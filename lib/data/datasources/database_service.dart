import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

class DatabaseService {
  late Isar _isar;

  Isar get isar => _isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        PetSchema,
        PetFoodSchema,
        FeedingLogSchema,
        HealthRecordSchema,
        ReminderSchema,
        ActivitySchema,
        ExpenseSchema,
        WeightRecordSchema,
        AppSettingsSchema,
      ],
      directory: dir.path,
      name: 'pet_log_db',
    );
  }

  Future<void> close() async {
    await _isar.close();
  }

  Future<void> clearAllData() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  Future<bool> isOnboardingCompleted() async {
    final settings = await _isar.appSettings.get(0);
    return settings?.onboardingCompleted ?? false;
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.appSettings.get(0);
      final settings = existing ??
          (AppSettings()
            ..id = 0
            ..notificationsEnabled = true
            ..createdAt = DateTime.now());
      settings
        ..onboardingCompleted = completed
        ..updatedAt = DateTime.now();
      await _isar.appSettings.put(settings);
    });
  }
}
