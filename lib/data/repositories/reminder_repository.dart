import 'package:isar/isar.dart';

import '../datasources/database_service.dart';
import '../models/reminder_model.dart';

class ReminderRepository {
  final DatabaseService _databaseService;

  ReminderRepository(this._databaseService);

  Isar get _isar => _databaseService.isar;

  Future<List<Reminder>> getAllReminders() async {
    return _isar.reminders.where().sortByReminderTime().findAll();
  }

  Future<List<Reminder>> getRemindersForPet(int petId) async {
    return _isar.reminders
        .filter()
        .petIdEqualTo(petId)
        .sortByReminderTime()
        .findAll();
  }

  Future<List<Reminder>> getActiveReminders() async {
    return _isar.reminders
        .filter()
        .isActiveEqualTo(true)
        .sortByReminderTime()
        .findAll();
  }

  Future<List<Reminder>> getUpcomingReminders({int days = 7}) async {
    final now = DateTime.now();
    final future = now.add(Duration(days: days));

    return _isar.reminders
        .filter()
        .isActiveEqualTo(true)
        .reminderTimeBetween(now, future)
        .sortByReminderTime()
        .findAll();
  }

  Future<Reminder?> getReminderById(int id) async {
    return _isar.reminders.get(id);
  }

  Future<int> addReminder(Reminder reminder) async {
    return _isar.writeTxn(() async {
      return _isar.reminders.put(reminder);
    });
  }

  Future<int> updateReminder(Reminder reminder) async {
    reminder.updatedAt = DateTime.now();
    return _isar.writeTxn(() async {
      return _isar.reminders.put(reminder);
    });
  }

  Future<bool> deleteReminder(int id) async {
    return _isar.writeTxn(() async {
      return _isar.reminders.delete(id);
    });
  }

  Future<void> toggleReminderActive(int id, bool isActive) async {
    final reminder = await getReminderById(id);
    if (reminder != null) {
      reminder.isActive = isActive;
      reminder.updatedAt = DateTime.now();
      await _isar.writeTxn(() async {
        await _isar.reminders.put(reminder);
      });
    }
  }

  Stream<List<Reminder>> watchAllReminders() {
    return _isar.reminders
        .where()
        .sortByReminderTime()
        .watch(fireImmediately: true);
  }

  Stream<List<Reminder>> watchRemindersForPet(int petId) {
    return _isar.reminders
        .filter()
        .petIdEqualTo(petId)
        .sortByReminderTime()
        .watch(fireImmediately: true);
  }
}
